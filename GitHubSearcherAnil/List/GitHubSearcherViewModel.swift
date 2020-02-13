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
    static let repositoryCountCache = NSCache<NSString, NSString>()
    
    func isLoggedIn() -> Bool {
        if let _ = UserDefaults.standard.value(forKey: "GitHubUsername") as? String, let _ = UserDefaults.standard.value(forKey: "GitHubPassword") as? String {
            return true
        } else {
            return false
        }
    }
    func loadUsers(completion: @escaping (_ success: Bool, _ errorDescription: String?) -> ()) {
        weak var weakSelf = self
        NetworkManager().GETcallUseCache(api: API.gitHubUsers.value) { (data, error) in
            if let jsonData = data {
                //let str = String(bytes: jsonData, encoding: String.Encoding.utf8)
                //print(str)
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

