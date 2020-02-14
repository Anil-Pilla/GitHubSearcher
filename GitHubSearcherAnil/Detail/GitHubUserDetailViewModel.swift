//
//  GitHubUserDetailViewModel.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 13/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation

class GitHubUserDetailViewModel {
    var user: GitHubUserDetail?
    private var repos = [[String: Any]]()
    
    func loadUser(userName: String, completion: @escaping (_ success: Bool, _ errorDescription: String?) -> ()) {
        weak var weakSelf = self
        NetworkManager().GETcall(api: API.gitHubUser(userName).value) { (data, error) in
            if let jsonData = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let user = try jsonDecoder.decode(GitHubUserDetail.self, from: jsonData)
                    weakSelf?.user = user
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
    
    func getRepos(repos: String, completion: @escaping (_ success: Bool, _ errorDescription: String?) -> ()) {
        NetworkManager().GETcall(api: repos) { (data, error) in
            if let jsonData = data {
                do {
                    if let reposArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [AnyObject] {
                        DispatchQueue.main.async {
                            if let repos = reposArray as? [[String: Any]] {
                                self.repos = repos
                                completion(true, nil)
                            }
                        }
                    } else {
                        completion(false, "Unkown error occurred")
                    }
                } catch {}
            } else if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(false, "Unkown error occurred")
            }
        }
    }
    
    func reposList(searchTerm: String? = nil) -> [[String: Any]] {
        if let str = searchTerm, str.count > 0 {
            let filteredUsers = repos.filter({ (repo) -> Bool in
                if let name = repo["name"] as? String {
                    return name.lowercased().range(of: str.lowercased()) != nil
                } else {
                    return false
                }
            })
            return filteredUsers
        }
        return repos
    }
}
