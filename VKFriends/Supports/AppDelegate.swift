//
//  AppDelegate.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authManager: AuthorizationManager?
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.authManager = AuthorizationManager()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    func showAuthWindow(_ viewController: UIViewController) {
        
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func showInfoWindow() {
        
        let friendsVC = UIStoryboard(name: "Friends", bundle: nil).instantiateInitialViewController() as! FriendsTableViewController
        let navigationVC = UINavigationController(rootViewController: friendsVC)
        window?.rootViewController = navigationVC
    }
}

