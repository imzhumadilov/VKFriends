//
//  NetworkModel.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private let authManager = AppDelegate.shared().authManager!
    
    func request(method: String, set: [String : String]?, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        guard let token = authManager.token else { return }
        
        var fullSet = [String : String]()
        
        if let set = set {
            
            fullSet = set
        }
        
        fullSet["access_token"] = token
        fullSet["v"] = "5.103"
        
        let request = URLRequest(url: createURL(method: method, set: fullSet))
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                completionHandler(data, error)
            }
        }.resume()
    }
    
    
    private func createURL(method: String, set: [String: String]) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method
        components.queryItems = set.map{ (key: String, value: String) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        }
        return components.url!
    }
}
