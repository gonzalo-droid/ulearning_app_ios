//
//  ULChatViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 7/12/23.
//

import UIKit

class ULChatViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var progressLoading: UIActivityIndicatorView!{
        didSet {
            progressLoading.hidesWhenStopped = true
        }
    }
    
    
    @IBOutlet weak var myConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnBack: UIButton!{
        didSet {
            btnBack.setTitle("", for: .normal)
            btnBack.setTitle("", for: .selected)
            btnBack.setTitle("", for: .focused)
            btnBack.addTarget(
                self,
                action: #selector(closeButtonPress(_:)),
                for: .touchUpInside
            )
        }
    }
    @IBOutlet weak var inputMessageHC: NSLayoutConstraint!
    
    @IBOutlet weak var inputMessage: UITextView!{
        didSet {
            inputMessage.layer.cornerRadius = 8
            inputMessage.layer.borderWidth = 1
            inputMessage.text = "Escribe un mensaje"
            inputMessage.font = UIFont.boldSystemFont(ofSize: 14)
            inputMessage.isScrollEnabled = false
            inputMessage.textColor = .blackUL

        }
    }
    
    @IBOutlet weak var sendButton: UIButton!{
        didSet {
            sendButton.setTitle("", for: .normal)
            sendButton.setTitle("", for: .focused)
            sendButton.setTitle("", for: .selected)
            sendButton.setTitle("", for: .disabled)
            sendButton.addTarget(
                self, action: #selector(buttonSendTapped(_:)),
                for: .touchUpInside
            )
        }
    }

    var index: IndexPath = IndexPath()
    var viewModel: ULChatViewModel
    var keyboardIsShown = false
    var messageList: [ULMessageItemTableCellViewModel] = []
    var previousTextViewHeight: CGFloat = 36
    
    init(viewModel: ULChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ULChatViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // registerForKeyboardNotifications(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // unregisterFromKeyboardNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeButtonPress(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }

    
    func configView() {
        self.view.backgroundColor = .white
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getMessageItems(uuid: viewModel.conversation.uuid!)
    }
    
    func getMessageItems(uuid:String){
        viewModel.getMessageItems(uuid: viewModel.conversation.uuid!)
    }
    
    func bindViewModel() {
        
        viewModel.setUUID.bind { [weak self] uuid in
            guard let uuid = uuid else {
                return
            }
            self?.getMessageItems(uuid: uuid)
        }
        
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.progressLoading.startAnimating()
                } else {
                    self?.progressLoading.stopAnimating()
                }
            }
        }
        
        viewModel.messages.bind { [weak self] messages in
            guard let self = self,
                  let messages = messages else {
                return
            }
            debugPrint("counts messages.bind")

            self.messageList = messages
            self.reloadTableView()
            self.scrollToBottom()
            prepareInfo()
        }
    }
    
    func prepareInfo(){
        
    }

    @objc func buttonSendTapped(_ sender: UIButton) {
        if let message = inputMessage.text, !message.isEmpty {
            inputMessage.resignFirstResponder()
            if let uuid = viewModel.conversation.uuid {
                viewModel.sendMessageSupport(uuid: uuid, content: message)
                self.inputMessage.text = ""
                inputMessageHC.constant = 36
                previousTextViewHeight = 36
                self.view.layoutIfNeeded()
            }
        }
    }

   

}

extension ULChatViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return true
        }

        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView == self.inputMessage {
        
            self.view.layoutIfNeeded()
        }
        
        
        if textView == self.inputMessage {
            let minHeight: CGFloat = 36
            let maxHeight: CGFloat = 185
            let fixedWidth = textView.frame.size.width
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newHeight = max(minHeight, newSize.height)
            newHeight = min(maxHeight, newHeight)

            inputMessageHC.constant = newHeight
            textView.isScrollEnabled = newHeight >= maxHeight

            if newHeight != previousTextViewHeight {
                let heightDifference = newHeight - previousTextViewHeight
                myConstraint.constant += heightDifference
                previousTextViewHeight = newHeight
            }
            self.view.layoutIfNeeded()
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .blackUL
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Escribe un mensaje"
            textView.textColor = .blackUL
        }
    }
}


extension ULChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollToBottom() {
            if tableView.numberOfSections > 0 {
                let lastSection = tableView.numberOfSections - 1
                let lastRow = tableView.numberOfRows(inSection: lastSection) - 1

                if lastRow >= 0 {
                    let indexPath = IndexPath(row: lastRow, section: lastSection)
                    tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func registerCells() {
        self.tableView.register(MessageItemTableViewCell.register(), forCellReuseIdentifier: MessageItemTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageItemTableViewCell.identifier, for: indexPath) as? MessageItemTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: messageList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = messageList[indexPath.row].id
    }
}
