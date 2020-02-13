//
//  GitHubSearcherViewModel.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 12/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation
import UIKit

class GitHubSearcherViewModel {
    var gitHubUsers: [GitHubUser]?
    static let imageCache = NSCache<NSString, UIImage>()
    
    
    func loadUsers(completion: @escaping (_ success: Bool, _ errorDescription: String?) -> ()) {
        weak var weakSelf = self
        NetworkManager.shared.GETcallUseCache(api: API.gitHubUsers.rawValue) { (data, error) in
            if let jsonData = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let users = try jsonDecoder.decode([GitHubUser].self, from: jsonData)
                    weakSelf?.gitHubUsers = users
                    completion(true, nil)
                } catch {
                    completion(false, "Unable to read the response")
                }
            } else if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(false, "Unknown error occurred")
            }
        }
    }
}

