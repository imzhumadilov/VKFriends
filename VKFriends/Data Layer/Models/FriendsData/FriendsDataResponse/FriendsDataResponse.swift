//
//  FriendsDataResponse.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 19.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

struct FriendsDataResponse: Decodable {
    let response: FriendsResponse?
    
    func defaultMapping() -> FriendsData {
        return FriendsData(friends: response?.defaultMapping() ?? Friends(users: []))
    }
}
