//
//  ULHomeViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/06/23.
//

import UIKit

class ULHomeViewController: UIViewController {
    
    
    @IBOutlet weak var userLabel: UILabel!{
        didSet {
            userLabel.font = UIFont.boldSystemFont(ofSize: 24)
            userLabel.textColor = .blackUL
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var subtitleLabel: UILabel!{
        didSet {
            subtitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            subtitleLabel.textColor = .blueUL
        }
    }
    
    
    @IBOutlet weak var titleCompletedLabel: UILabel!{
        didSet {
            titleCompletedLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleCompletedLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var subtitleCompletedLabel: UILabel!{
        didSet {
            subtitleCompletedLabel.font = UIFont.boldSystemFont(ofSize: 14)
            subtitleCompletedLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var titlePackageLabel: UILabel!{
        didSet {
            titlePackageLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titlePackageLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var subtitlePackageLabel: UILabel!{
        didSet {
            subtitlePackageLabel.font = UIFont.boldSystemFont(ofSize: 14)
            subtitlePackageLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var titleRouteLabel: UILabel!{
        didSet {
            titleRouteLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleRouteLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var subtitleRouteLabel: UILabel!{
        didSet {
            subtitleRouteLabel.font = UIFont.boldSystemFont(ofSize: 14)
            subtitleRouteLabel.textColor = .blueUL
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var containerIconView: UIView! {
        didSet {
            containerIconView.layer.cornerRadius = 10
            containerIconView.backgroundColor = .blueA100UL
        }
    }
    
    
    @IBOutlet weak var containerIconCompletedView: UIView!{
        didSet {
            containerIconCompletedView.layer.cornerRadius = 10
            containerIconCompletedView.backgroundColor = .blueA100UL
        }
    }
    
    @IBOutlet weak var containerIconPackageView: UIView!{
        didSet {
            containerIconPackageView.layer.cornerRadius = 10
            containerIconPackageView.backgroundColor = .blueA100UL
        }
    }
    
    @IBOutlet weak var containerIconRouteView: UIView!{
        didSet {
            containerIconRouteView.layer.cornerRadius = 10
            containerIconRouteView.backgroundColor = .blueA100UL
        }
    }
    
    
    @IBOutlet weak var containerCardView: UIView! {
        didSet {
            containerCardView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var containerCardCompletedView: UIView!{
        didSet {
            containerCardCompletedView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var containerCardPackageView: UIView!{
        didSet {
            containerCardPackageView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var containerCardRouteView: UIView!{
        didSet {
            containerCardRouteView.layer.cornerRadius = 8
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        CourseService.getSubscriptions(
            page: 1,
            isFinished: false,
            successBlock: { [weak self] subscriptions in
                guard let self = self else { return }
                print(subscriptions.count)
                
            }, errorBlock: { [weak self] error in
                guard let self = self else { return }
                print(error!)
            })
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
