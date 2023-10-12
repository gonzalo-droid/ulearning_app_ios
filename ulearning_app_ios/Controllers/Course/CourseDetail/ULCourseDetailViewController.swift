//
//  ULCourseDetailViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/08/23.
//

import UIKit

enum DetailsComponents {
    case detailComponent(data: ULSubscription)
    case topicsComponent(topics: [ULTopic])
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
    var listTopics: [ULTopic] = []
    
    init(viewModel: ULCourseDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ULCourseDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getTokenWeb()
                    
        tableView.delegate = self
        tableView.dataSource = self
       
        tableView.register(UINib(nibName: "DetailComponentTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "DetailComponentTableViewCell")

        tableView.register(UINib(nibName: "ULTopicComponentTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "ULTopicComponentTableViewCell")
        
        viewModel.getTopicsData(courseId: viewModel.subscription.courseId)
        
        viewModel.topicsObservable.bind { [weak self] topicsObservable in
            guard let self = self,
                  let topicsObservable = topicsObservable else {
                return
            }
            self.listTopics = topicsObservable
            prepareInfo()
        }
    }
    
    func prepareInfo() {
        self.details.removeAll()
        details = [
            .detailComponent(
                data: self.viewModel.subscription
            )
        ]
        
        details.append(
            .topicsComponent(
                topics: listTopics
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
        case .topicsComponent(topics: let data):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ULTopicComponentTableViewCell.self)
            ) as! ULTopicComponentTableViewCell
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

extension ULCourseDetailViewController: DetailComponentTableViewCellProtocol {
    func goToMessageButtonPress(courseID: Int) {
        DispatchQueue.main.async {
            let controller = ULMessageViewController()
            controller.typeMessage = "course"
            controller.courseID = courseID
            self.present(controller, animated: true, completion: nil)
        }
    }
    

    func closeButtonPress(sender: UIButton, cell: DetailComponentTableViewCell) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ULCourseDetailViewController: ULTopicComponentTableViewCellProtocol {
    func showDetails(topic: ULTopic) {
        let parms = "/courses/\(String(describing: topic.courseId))/topics/\(String(describing: topic.id))"
        
        if let urlViewModel = viewModel.urlTopic {
            let webTopic = "\(urlViewModel)?return=\(parms)"
            if let url = URL(string: webTopic ?? viewModel.urlStudent) {
                UIApplication.shared.open(url, options: [:])
            }
        }
        
       
    }
    
    func goToMessageBtn(sender: UIButton, cell: ULTopicComponentTableViewCell) {
        // 
    }

}
