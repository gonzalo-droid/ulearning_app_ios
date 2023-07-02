//
//  ULHomeViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/06/23.
//

import UIKit

class ULHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Home"
        
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
