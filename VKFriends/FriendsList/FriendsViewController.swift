//
//  FriendsViewController.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {

    private let networkManager = VKService()
    private var friends = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFriends()
        userData()
    }
    
    func userData() {
        
        networkManager.getMyProfile() { (result) in
            
            switch result {
            case .success(let profile):
                self.title = profile.firstName + " " + profile.lastName
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateFriends() {
        
        networkManager.getFriends(count: 5, order: "random", fields: ["sex"]) { (result) in
            
            switch result {
            case .success(let friends):
                self.friends = friends
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = friends[indexPath.row].firstName + " " + friends[indexPath.row].lastName
        return cell
    }
}
