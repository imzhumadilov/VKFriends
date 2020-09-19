//
//  AuthorizationViewController.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {

    // MARK: - Props
    private var authManager: AuthorizationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authManager = AppDelegate.shared().authService
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        authManager?.createSession()
    }
}

