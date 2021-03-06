//
//  FriendsViewController.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 05.04.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {

    // MARK: - Properties
    private let viewModel = FriendsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.loadData()
    }
    
    // MARK: - Module functions
    private func bindViewModel() {

        viewModel.loadDataCompletion = { [weak self] result in
            
            switch result {
                
            case .success(let data):
                if let profile = data.profile {
                    self?.title = profile.firstName + " " + profile.lastName
                }
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let friends = viewModel.friends else { return 0 }
        
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let friends = viewModel.friends else { return UITableViewCell() }
        
        cell.textLabel?.text = friends[indexPath.row].firstName + " " + friends[indexPath.row].lastName
        return cell
    }
}
