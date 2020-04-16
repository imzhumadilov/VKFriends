//
//  ParseModel.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 16.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

struct UserData: Decodable {
    let response: [Item]
}

struct FriendsData: Decodable {
    let response: Items
}

struct Items: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let firstName: String
    let lastName: String
}
