//
//  ULTabBarViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/06/23.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class ULTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }

    private func setUpTabs() {
        let homeVC = ULHomeViewController()
        let messageVC = ULMessageViewController()
        let profileVC = ULProfileViewController()

        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        messageVC.navigationItem.largeTitleDisplayMode = .automatic
        profileVC.navigationItem.largeTitleDisplayMode = .automatic

        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: messageVC)
        let nav3 = UINavigationController(rootViewController: profileVC)

    
        nav1.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house.fill"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Chat",
                                       image: UIImage(systemName: "ellipsis.message.fill"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Perfil",
                                       image: UIImage(systemName: "person"),
                                       tag: 3)

        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }

        setViewControllers(
            [nav1, nav2, nav3],
            animated: true
        )
    }

}
