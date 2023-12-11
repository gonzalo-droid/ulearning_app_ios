//
//  ULChatViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 7/12/23.
//

import UIKit

class ULChatViewController: UIViewController {
    
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
    
    @objc func buttonSendTapped(_ sender: UIButton) {
       
    }

    var index: IndexPath = IndexPath()
    var viewModel: ULChatViewModel
    var keyboardIsShown = false
    var messageList: [ULMessageItemTableCellViewModel] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    init(viewModel: ULChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ULChatViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeButtonPress(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    func configView() {
        self.view.backgroundColor = .white
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getMessageItems(uuid: viewModel.conversation.uuid!)
    }
    
    func bindViewModel() {
        viewModel.messages.bind { [weak self] messages in
            guard let self = self,
                  let messages = messages else {
                return
            }
            self.messageList = messages
            self.reloadTableView()
            prepareInfo()
        }
    }
    
    func prepareInfo(){
        
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
        150
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
