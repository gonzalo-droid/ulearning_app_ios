//
//  ULMessageViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/06/23.
//

import UIKit

class ULMessageViewController: UIViewController {
    
    let MESSAGE_SUPPORT = "support"

    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            titleLabel.textColor = .blackUL
        }
    }
    
    @IBOutlet weak var addMessageButton: UIButton!{
        didSet {
            addMessageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        }
    }
    
    @IBOutlet weak var messageTableView: UITableView!
    
    var viewModel: ULMessageSupportViewModel = ULMessageSupportViewModel()
    var conversationsDataSource: [ULMessageTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    func configView() {
        self.view.backgroundColor = .systemBackground
        self.setupTableView()
        
        addMessageButton.addTarget(self, action: #selector(addMessageButtonButtonTapped), for: .touchUpInside)

    }
    
    @objc func addMessageButtonButtonTapped() {
        DispatchQueue.main.async {
            let viewModel = ULAddMessageSupportViewModel(typeMessage: self.MESSAGE_SUPPORT, courseId: nil, userIds: nil)
            let controller = ULAddMessageViewController(viewModel: viewModel)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    func bindViewModel() {
        
        viewModel.conversations.bind { [weak self] conversations in
            guard let self = self,
                  let conversations = conversations else {
                return
            }
            self.conversationsDataSource = conversations
            self.reloadTableView()
        }
    }
    
    func openMessageSupport(id: Int) {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}


extension ULMessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        self.messageTableView.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.messageTableView.reloadData()
        }
    }
    
    func registerCells() {
        self.messageTableView.register(ULConversationTableViewCell.register(), forCellReuseIdentifier: ULConversationTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ULConversationTableViewCell.identifier, for: indexPath) as? ULConversationTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: conversationsDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = conversationsDataSource[indexPath.row].id
        self.openMessageSupport(id: id)
    }
}
