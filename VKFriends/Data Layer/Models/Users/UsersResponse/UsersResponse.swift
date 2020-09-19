//
//  UsersResponse.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 19.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

struct UsersResponse: Decodable {
    let response: [ProfileResponse?]?
    
    func defaultMapping() -> Users {
        return Users(profile: response?.compactMap({ $0?.defaultMapping() }) ?? [])
    }
}
