//
//  FriendsResponse.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 19.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

struct FriendsResponse: Decodable {
    let items: [ProfileResponse?]?
    
    func defaultMapping() -> Friends {
        return Friends(users: items?.compactMap({ $0?.defaultMapping() }) ?? [])
    }
}
