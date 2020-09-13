//
//  ParseModel.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 16.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

struct FriendsData {
    let friends: Friends
}

struct Friends {
    let users: [Profile]
}

struct FriendsDataResponse: Decodable {
    let response: FriendResponse?
    
    func defaultMapping() -> FriendsData {
        return FriendsData(friends: response?.defaultMapping() ?? Friends(users: []))
    }
}

struct FriendResponse: Decodable {
    let items: [ProfileResponse?]?
    
    func defaultMapping() -> Friends {
        return Friends(users: items?.compactMap({ $0?.defaultMapping() }) ?? [])
    }
}



struct Users {
    let profile: [Profile]
}

struct Profile {
    let firstName: String
    let lastName: String
}

struct UsersResponse: Decodable {
    let response: [ProfileResponse?]?
    
    func defaultMapping() -> Users {
        return Users(profile: response?.compactMap({ $0?.defaultMapping() }) ?? [])
    }
}

struct ProfileResponse: Decodable {
    let firstName: String?
    let lastName: String?
    
    func defaultMapping() -> Profile {
        return Profile(firstName: firstName ?? "",
                    lastName: lastName ?? "")
    }
}
