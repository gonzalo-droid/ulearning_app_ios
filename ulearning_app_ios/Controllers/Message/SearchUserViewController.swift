//
//  SearchUserViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/01/24.
//

import UIKit

protocol SearchUserViewControllerProtocol: AnyObject {
    func didReceiveData(_ data: ULUser)
}

class SearchUserViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!{
        didSet {
            backBtn.setTitle("", for: .normal)
            backBtn.setTitle("", for: .selected)
            backBtn.setTitle("", for: .focused)
            backBtn.addTarget(
                self,
                action: #selector(closeButtonPress),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var selectUserLabel: UILabel!{
        didSet {
            selectUserLabel.text = "Seleccionar usuario"
            selectUserLabel.font = UIFont.boldSystemFont(ofSize: 24)
            selectUserLabel.textColor = .blackUL
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!{
        didSet {
            progressIndicator.hidesWhenStopped = true
        }
    }
    
    var delegate: SearchUserViewControllerProtocol?
    var viewModel: ULSearchUserViewModel = ULSearchUserViewModel()
    var usersDataSource: [ULSearchUserTableCellViewModel] = []

    var courseID: Int?

    init(delegate: SearchUserViewControllerProtocol) {
        self.delegate = delegate
        super.init(nibName: "SearchUserViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    func configView() {
        self.view.backgroundColor = .systemBackground
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let courseID = courseID {
            viewModel.getData(courseID: courseID)
        }
    }
    
    
    func bindViewModel() {
        
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.progressIndicator.startAnimating()
                } else {
                    self?.progressIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.users.bind { [weak self] users in
            guard let self = self,
                  let users = users else {
                return
            }
            
            self.usersDataSource = users
            self.reloadTableView()
        }
    }
    
    func selectUser(id: Int) {
        guard let user = viewModel.retriveUser(withId: id) else {
            return
        }
        delegate?.didReceiveData(user)
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func closeButtonPress() {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}


extension SearchUserViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        self.tableView.register(SearchUserItemTableViewCell.register(), forCellReuseIdentifier: SearchUserItemTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchUserItemTableViewCell.identifier, for: indexPath) as? SearchUserItemTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: usersDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = usersDataSource[indexPath.row].id
        self.selectUser(id: id)
    }
}

