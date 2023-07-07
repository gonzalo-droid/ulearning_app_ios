//
//  ULProgressCouseViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 6/07/23.
//

import UIKit

class ULProgressCouseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Progreso"
        
        setupNav()
    }

    
    private func setupNav() {
        if let nav = self.navigationController {
            let backButtonImage = UIImage(systemName: "house.fill")
            // navigationItem.hidesBackButton = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: backButtonImage,
                style: .plain,
                target: self,
                action: #selector(back(_:))
            )

            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance(idiom: .phone)
                // For normal title.
                appearance.titleTextAttributes = [
                    .foregroundColor: UIColor.black,
                    .font: UIFont.boldSystemFont(ofSize: 14)
                ]

                appearance.backgroundColor = .white
                navigationItem.standardAppearance = appearance
                navigationItem.scrollEdgeAppearance = appearance
            } else {
                // For normal title.
                let atrr2 = [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
                ]
                nav.navigationBar.titleTextAttributes = atrr2
            }
        }
        
    }
    
    @objc func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }

}
