//
//  ULCourseDetailViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/08/23.
//

import UIKit

enum DetailsComponents {
    case detailComponent(data: ULSubscription)
    // case topicsComponent(data: ULSubscription)
}

class ULCourseDetailViewController: UIViewController {

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
    
    var details: [DetailsComponents] = []
    var index: IndexPath = IndexPath()
    var viewModel: ULCourseDetailViewModel
    
    init(viewModel: ULCourseDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ULCourseDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
       
        
        tableView.register(UINib(nibName: "DetailComponentTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "DetailComponentTableViewCell")

        
        prepareInfo()

    }
    
    func prepareInfo() {
        self.details.removeAll()
        details = [
            .detailComponent(data: self.viewModel.subscription)
        ]

        self.tableView.reloadData()
    }
    
    func configNavBar() {
        if let nav = self.navigationController {
            let title = self.viewModel.title
            navigationItem.hidesBackButton = true
            nav.navigationItem.largeTitleDisplayMode = .never
            nav.navigationBar.prefersLargeTitles = false
            nav.navigationBar.sizeToFit()

            self.title = title
            self.navigationItem
                .titleView =  setTitle(title: title,
                                       titleColor: .blueUL,
                                       titleSize: 18,
                                       view: self.view)

            let searchButtonItem = UIBarButtonItem(
                image: UIImage(
                    named: "arrow.backward"
                ),
                style: .plain,
                target: self,
                action: #selector(backButtonPressed)
            )

            self.navigationItem.rightBarButtonItems = [
                searchButtonItem,
            ]
        }

    }
    
    func setTitle(title: String,
                  titleColor: UIColor,
                  titleSize: CGFloat,
                  view: UIView) -> UIView {

        let titleLabel = UILabel(frame: CGRect(x:8, y: 0, width: view.frame.width - 100, height: 30))

        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = titleColor
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleSize)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .left
        titleLabel.text = title

        let titleView = UIView(frame: CGRect(x:0, y:0, width: view.frame.width - 30, height:30))
        titleView.addSubview(titleLabel)

        return titleView
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

extension ULCourseDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = details[indexPath.row]
        switch component {
        case .detailComponent(data: let data):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailComponentTableViewCell.self)
            ) as! DetailComponentTableViewCell
            cell.selectionStyle = .none
            cell.setupCell(data: data, delegate: self)
            return cell
        }
            /*
        case .topicsComponent(data: let data):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: DetailComponentTableViewCell.self)
            ) as! DetailComponentTableViewCell
            cell.selectionStyle = .none
            cell.setupCell(data: data, delegate: self)
            return cell
        } */
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

extension ULCourseDetailViewController: DetailComponentTableViewCellProtocol {

    func closeButtonPress(sender: UIButton, cell: DetailComponentTableViewCell) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}
