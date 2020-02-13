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
    var operationQueue: OperationQueue {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 3
        return operationQueue
    }
    
    let dispatchGroup = DispatchGroup()
    
    private init() {
        
    }
    
    func GETcall(api: String, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: URL(string: api)!) { (data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
    
    func GETcallUseCache(api: String, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        var request = URLRequest(url: URL(string: api)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10.0)
        request.addValue("Anil-Pilla", forHTTPHeaderField: "my_username")
        request.addValue("my_password", forHTTPHeaderField: "Anil@cocoa1")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
    
    func GETcallInsideQueues(api: String, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        operationQueue.addOperation {
            self.GETcallUseCache(api: api, completion: { (data, error) in
                completion(data, error)
            })
        }
    }
}
