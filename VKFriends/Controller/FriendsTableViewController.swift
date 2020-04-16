//
//  FriendsTableViewController.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    private let networkManager = NetworkManager()
    private var friends = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFriends()
        userData()
    }
    
    func userData() {
        
        networkManager.request(method: "/method/users.get", set: nil) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let decodedData = self.dataDecoding(type: UserData.self, data: data),
                decodedData.response.count > 0 else { return }
            
            self.title = decodedData.response[0].firstName + " " + decodedData.response[0].lastName
        }
    }
    
    func updateFriends() {
        
        let set = ["fields": "sex", "count": "5", "order": "random"]
        
        networkManager.request(method: "/method/friends.get", set: set) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let decodedData = self.dataDecoding(type: FriendsData.self, data: data) else { return }
            
            for i in 0..<decodedData.response.items.count {
                
                let item = decodedData.response.items[i]
                self.friends.append(item.firstName + " " + item.lastName)
            }
            
            self.tableView.reloadData()
        }
    }
    
    private func dataDecoding <T: Decodable> (type: T.Type, data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let decodedData = try? decoder.decode(type, from: data) else { return nil }
        return decodedData
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = friends[indexPath.row]
        return cell
    }
}
