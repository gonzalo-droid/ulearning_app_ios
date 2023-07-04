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
            userLabel.font = UIFont.boldSystemFont(ofSize: 15)
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
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var containerIconView: UIView! {
        didSet {
            containerIconView.layer.cornerRadius = 10
            containerIconView.backgroundColor = .blueA100UL
        }
    }
        
    @IBOutlet weak var containerCardView: UIView! {
        didSet {
            containerCardView.layer.cornerRadius = 20
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
