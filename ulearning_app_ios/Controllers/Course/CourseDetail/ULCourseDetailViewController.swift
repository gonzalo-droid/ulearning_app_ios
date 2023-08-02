//
//  ULCourseDetailViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/08/23.
//

import UIKit

enum DetailsComponents {
    case detailComponent(data: ULSubscription)
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
        
        print("log viewModel \(viewModel.title)")
        
        configNavBar()
        tableView.register(
            ULDetailComponentTableViewCell().nib,
            forCellReuseIdentifier: String(describing: ULDetailComponentTableViewCell.self)
        )

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
