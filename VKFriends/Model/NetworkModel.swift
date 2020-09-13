//
//  NetworkModel.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

class VKService {
    
    private let authManager = AppDelegate.shared().authService
    
    func getUser(completion: @escaping ((Result<Profile, Error>) -> Void)) {
        
        let params = ["access_token" : (authManager?.token)!,
                       "v" : "5.103"]
        
        var url = URLComponents(string: "https://api.vk.com/method/users.get")
        
        url?.queryItems = params.map ({ URLQueryItem(name: $0.key, value: $0.value) })
        
        URLSession.shared.dataTask(with: (url?.url)!) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let decodedData = self.dataDecoding(type: UsersResponse.self, data: data),
                let profile = decodedData.defaultMapping().profile.first else { return }
            
            DispatchQueue.main.async {
                completion(.success(profile))
            }
        }.resume()
    }
    
    
    
    func getFriends(count: Int = 5000, order: String = "", fields: [String] = [], completion: @escaping ((Result<[Profile], Error>) -> Void)) {
        
        var params = ["access_token" : (authManager?.token)!,
                       "v" : "5.103",
                       "count": String(count)]
        
        if !order.isEmpty { params["order"] = order }
        if !fields.isEmpty { params["fields"] = fields.joined(separator: ",") }
        
        var url = URLComponents(string: "https://api.vk.com/method/friends.get")
        url?.queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        URLSession.shared.dataTask(with: (url?.url)!) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let decodedData = self.dataDecoding(type: FriendsDataResponse.self, data: data) else { return }
            
            let friends = decodedData.defaultMapping().friends.users
            
            DispatchQueue.main.async {
                completion(.success(friends))
            }
        }.resume()
    }
    
    private func dataDecoding <T: Decodable> (type: T.Type, data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let decodedData = try? decoder.decode(type, from: data) else { return nil }
        return decodedData
    }
}
