//
//  AuthorizationModel.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation
import VKSdkFramework

class AuthorizationManager: NSObject {
    
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
    
    func session() {
        
        let scope = ["offline", "friends"]
        
        VKSdk.wakeUpSession(scope) { authorizationState, error in
            
            if authorizationState == VKAuthorizationState.initialized {
                
                VKSdk.authorize(scope)
                
            } else if authorizationState == VKAuthorizationState.authorized {
                
                self.appDelegate.showInfoWindow()
                
            } else if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
}

extension AuthorizationManager: VKSdkDelegate, VKSdkUIDelegate {
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        
        appDelegate.showAuthWindow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {}
    
    
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        
        if result.token != nil {
            
            appDelegate.showInfoWindow()
            
        } else if let error = result.error {
            
            print(error.localizedDescription)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {}
}
