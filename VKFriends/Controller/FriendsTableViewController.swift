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
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
                let JSON = json["response"] as? [[String: AnyObject]],
                JSON.count > 0,
                let name = JSON[0]["first_name"] as? String,
                let surname = JSON[0]["last_name"] as? String else { return }
            
            self.title = name + " " + surname
        }
    }
    
    func updateFriends() {
        
        let set = ["fields": "sex", "count": "5", "order": "random"]
        
        networkManager.request(method: "/method/friends.get", set: set) { (data, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
            
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
                let jsonR = json["response"] as? [String: AnyObject],
                let JSON = jsonR["items"] as? [[String: AnyObject]] else { return }
            
            for i in 0..<JSON.count {
                guard let name = JSON[i]["first_name"] as? String,
                    let surname = JSON[i]["last_name"] as? String else { return }
                self.friends.append(name + " " + surname)
            }
            self.tableView.reloadData()
        }
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
