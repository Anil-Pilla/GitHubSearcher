//
//  NetworkManager.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 12/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation

enum API: String {
    case gitHubUsers = "https://api.github.com/users"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func getCall(completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: URL(string: API.gitHubUsers.rawValue)!) { (data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
}
