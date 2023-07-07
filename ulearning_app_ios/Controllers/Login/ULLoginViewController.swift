//
//  ULLoginViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 5/07/23.
//

import UIKit

class ULLoginViewController: UIViewController {

    @IBAction func doLoginButton(_ sender: UIButton) {
        let homeTab = ULTabBarViewController()
        self.present(homeTab, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
