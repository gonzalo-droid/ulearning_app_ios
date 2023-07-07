//
//  AppDelegate.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 22/06/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let status = false
        if status {
            let vc = UINavigationController(rootViewController: ULLoginViewController())
            window.rootViewController = vc

        } else {
            let vc = UINavigationController(rootViewController: ULTabBarViewController())
            window.rootViewController = vc
        }
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }

}

