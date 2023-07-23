//
//  ULRouteCourseViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 7/07/23.
//

import UIKit

class ULRouteCourseViewController: UIViewController {
    
    @IBOutlet weak var coursesTableView: UITableView!
    
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!{
        didSet {
            progressIndicator.hidesWhenStopped = true
        }
    }
    
    var viewModel: ULPackageCourseViewModel = ULPackageCourseViewModel()
    
    var subscriptionsDataSource: [ULLearningPackageTableCellViewModel] = []
    
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
        viewModel.getData(type: "path")
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
            navigationItem.title = "Rutas de aprendizaje"
            
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
        
        viewModel.subscriptions.bind { [weak self] subscriptions in
            guard let self = self,
                  let subscriptions = subscriptions else {
                return
            }
            self.subscriptionsDataSource = subscriptions
            self.reloadTableView()
        }
    }
}


extension ULRouteCourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.coursesTableView.delegate = self
        self.coursesTableView.dataSource = self
        self.coursesTableView.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.coursesTableView.reloadData()
        }
    }
    
    func registerCells() {
        self.coursesTableView.register(ULLearningPackageTableViewCell.register(), forCellReuseIdentifier: ULLearningPackageTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ULLearningPackageTableViewCell.identifier, for: indexPath) as? ULLearningPackageTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: subscriptionsDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = subscriptionsDataSource[indexPath.row].id
        // self.openDetails(movieId: movieId)
    }
}
