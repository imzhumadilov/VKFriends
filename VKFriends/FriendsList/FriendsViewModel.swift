//
//  FriendsViewModel.swift
//  VKFriends
//
//  Created by Ilyas Zhumadilov on 13.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

class FriendsViewModel {
    
    // MARK: - Props
    var loadDataCompletion: ((Result<(profile: Profile?, friends: [Profile]?), Error>) -> Void)?
    private let vkService = VKService()
    
    // MARK: - Public functions
    public func loadData() {
        
        vkService.getMyProfile() { (result) in
            
            switch result {
            case .success(let profile):
                self.loadDataCompletion?(.success((profile, nil)))
                
                self.vkService.getFriends(count: 5, order: "random", fields: ["sex"]) { (result) in
                    
                    switch result {
                    case .success(let friends):
                        self.loadDataCompletion?(.success((profile, friends)))
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
