//
//  AppDelegate.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 22/06/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        if let _ = ULUserStore().getToken() {
            let vc = UINavigationController(rootViewController: ULTabBarViewController())
            window.rootViewController = vc
        } else {
            let vc = UINavigationController(rootViewController: ULLoginViewController())
            window.rootViewController = vc
        }
    
        window.makeKeyAndVisible()
        
        self.window = window
        
        FirebaseApp.configure()
        
        return true
    }

    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    func changeRootViewController(_ viewcontroller: UIViewController) {
        let desiredViewController = viewcontroller

        let snapshot:UIView = (self.window?.snapshotView(afterScreenUpdates: true))!
        desiredViewController.view.addSubview(snapshot)

        self.window?.rootViewController = desiredViewController

        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview();
        })
    }

}

