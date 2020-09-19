//
//  VKService.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

class VKService {
    
    // MARK: - Props
    private let authManager = AppDelegate.shared().authService
    private let version = "5.103"
    
    // MARK: - Public functions
    public func getMyProfile(completion: @escaping ((Result<Profile, Error>) -> Void)) {
        
        var params = ["v" : version]
        
        if let token = authManager?.token { params["access_token"] = token }
        
        var url = URLComponents(string: Routing.Vk.users)
        url?.queryItems = params.map ({ URLQueryItem(name: $0.key, value: $0.value) })
        
        guard let URL = url?.url else { return }
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            
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
    
    public func getFriends(count: Int = 5000, order: String = "", fields: [String] = [], completion: @escaping ((Result<[Profile], Error>) -> Void)) {
        
        var params = ["v" : version, "count": String(count)]
        
        if let token = authManager?.token { params["access_token"] = token }
        if !order.isEmpty { params["order"] = order }
        if !fields.isEmpty { params["fields"] = fields.joined(separator: ",") }
        
        var url = URLComponents(string: Routing.Vk.friends)
        url?.queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        guard let URL = url?.url else { return }
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            
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
    
    // MARK: - Module functions
    private func dataDecoding <T: Decodable> (type: T.Type, data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let decodedData = try? decoder.decode(type, from: data) else { return nil }
        return decodedData
    }
}
