//
//  ProfileResponse.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 19.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

struct ProfileResponse: Decodable {
    let firstName: String?
    let lastName: String?
    
    func defaultMapping() -> Profile {
        return Profile(firstName: firstName ?? "",
                    lastName: lastName ?? "")
    }
}
