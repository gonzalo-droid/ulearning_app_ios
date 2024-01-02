//
//  SearchUserViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/01/24.
//

import UIKit

class SearchUserViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!{
        didSet {
            progressIndicator.hidesWhenStopped = true
        }
    }
    
    var viewModel: ULSearchUserViewModel = ULSearchUserViewModel()
    var usersDataSource: [ULSearchUserTableCellViewModel] = []

    var courseID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        setupNav()
        bindViewModel()
    }
    
    func configView() {
        self.view.backgroundColor = .systemBackground
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData(courseID: 1)
    }
    
    
    private func setupNav() {
        if let nav = self.navigationController {
            let backButtonImage = UIImage(systemName: "arrow.backward")
            // navigationItem.hidesBackButton = true

            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: backButtonImage,
                style: .plain,
                target: self,
                action: #selector(back(_:))
            )
            
            navigationItem.title = "Selecciona un usuario"
            
            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance(idiom: .phone)
                // For normal title.
                appearance.titleTextAttributes = [
                    .foregroundColor: UIColor.black,
                    .font: UIFont.boldSystemFont(ofSize: 16)
                ]
                
                appearance.backgroundColor = .white
                navigationItem.standardAppearance = appearance
                navigationItem.scrollEdgeAppearance = appearance
            } else {
                // For normal title.
                let atrr2 = [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
                ]
                nav.navigationBar.titleTextAttributes = atrr2
            }
            
            
        
        }
        
    }
    
    @objc func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
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
        self.tableView.register(ULCourseTableViewCell.register(), forCellReuseIdentifier: ULCourseTableViewCell.identifier)
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

