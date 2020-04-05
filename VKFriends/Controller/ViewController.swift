//
//  ViewController.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var authManager: AuthorizationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authManager = AppDelegate.shared().authManager
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        authManager?.session()
    }
}

