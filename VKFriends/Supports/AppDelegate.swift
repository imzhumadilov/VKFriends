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
    var authService: AuthorizationService?
    
    static func shared() -> AppDelegate {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return AppDelegate() }
        
        return appDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.authService = AuthorizationService()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
    
    // MARK: - Public functions
    public func presentAuthorizationViewController(_ viewController: UIViewController) {
        
        window?.rootViewController?.present(viewController, animated: true)
    }
    
    func presentFriendsViewController() {
        
        guard let friendsVC = UIStoryboard(name: "Friends", bundle: nil).instantiateInitialViewController() as? FriendsViewController else { return }
        
        let navigationVC = UINavigationController(rootViewController: friendsVC)
        window?.rootViewController = navigationVC
    }
}

