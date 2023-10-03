//
//  ULPackageDetailViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/09/23.
//

import UIKit

enum PackageDetailsComponents {
    case bannerComponent(data: ULSubscription?)
    case tabBarComponent(data: ULSubscription?)
}

class ULPackageDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.clipsToBounds = true
            tableView.layer.cornerRadius = 10
            tableView.layer.maskedCorners = [
                .layerMaxXMinYCorner,
                .layerMinXMinYCorner
            ]
        }
    }
    
    var details: [PackageDetailsComponents] = []
    var index: IndexPath = IndexPath()
    var viewModel: ULPackageDetailViewModel
    var subscriptionData: ULSubscription?

    
    init(viewModel: ULPackageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ULPackageDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getLearningPackage()
        
        tableView.delegate = self
        tableView.dataSource = self
       
        tableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BannerTableViewCell")

        tableView.register(UINib(nibName: "TaBarDetailTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TaBarDetailTableViewCell")
        
        viewModel.dataObservable.bind { [weak self] dataObservable in
            guard let self = self,
                  let dataObservable = dataObservable else {
                return
            }
            self.subscriptionData = dataObservable
            prepareInfo()
        }
    }
    
    func prepareInfo() {
        self.details.removeAll()
        details = [
            .bannerComponent(
                data: self.subscriptionData
            )
        ]
        
        details.append(
            .tabBarComponent(
                data: self.subscriptionData
            )
        )

        self.tableView.reloadData()
    }
    
    func setupNavigationBar(){
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ULPackageDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = details[indexPath.row]
        switch component {
        case .bannerComponent(data: let data):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: BannerTableViewCell.self)
            ) as! BannerTableViewCell
            cell.selectionStyle = .none
            cell.setupCell(data: data, delegate: self)
            return cell
        case .tabBarComponent(data: let data):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: TaBarDetailTableViewCell.self)
            ) as! TaBarDetailTableViewCell
            cell.selectionStyle = .none
            cell.setupCell(data: data, delegate: self)
            return cell
        }
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeAreaTop = UIApplication.shared.windows.filter
        { $0.isKeyWindow }.first?.safeAreaInsets.top ?? 0


        let magicalSafeAreaTop: CGFloat = safeAreaTop +
        (navigationController?.navigationBar.frame.height ?? 0)

        if (scrollView.contentOffset.y >= magicalSafeAreaTop) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)

        }
    }

}

extension ULPackageDetailViewController: BannerTableViewCellProtocol {

}

extension ULPackageDetailViewController: TaBarDetailTableViewCellProtocol {

}
