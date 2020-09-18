//
//  AuthorizationModel.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation
import VKSdkFramework

class AuthorizationService: NSObject {
    
    // MARK: - Props
    private let appDelegate = AppDelegate.shared()
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        super.init()
        
        let vkSdk = VKSdk.initialize(withAppId: "7384295")
        vkSdk?.register(self)
        vkSdk?.uiDelegate = self
    }
    
    // MARK: - Public functions
    public func createSession() {
        
        let scope = ["offline", "friends"]
        
        VKSdk.wakeUpSession(scope) { authorizationState, error in
            
            if authorizationState == VKAuthorizationState.initialized {
                
                VKSdk.authorize(scope)
                
            } else if authorizationState == VKAuthorizationState.authorized {
                
                self.appDelegate.presentFriendsViewController()
                
            }
        }
    }
}

// MARK: - VKSdkDelegate, VKSdkUIDelegate
extension AuthorizationService: VKSdkDelegate, VKSdkUIDelegate {
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        
        appDelegate.presentAuthorizationViewController(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) { }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        
        if result.token != nil {
            appDelegate.presentFriendsViewController()
        }
    }
    
    func vkSdkUserAuthorizationFailed() { }
}
