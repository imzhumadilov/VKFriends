//
//  Routing.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 13.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

enum Routing {
    
    static let VkServiceUrl = "https://api.vk.com"
    
    enum Vk {
        static let method = VkServiceUrl + "/method"
        static let users = method + "/users.get"
        static let friends = method + "/friends.get"
    }
}
