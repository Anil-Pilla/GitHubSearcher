//
//  NetworkManager.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 12/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation

enum API {
    case gitHubUsers
    case gitHubUser(String)
    
    var value: String {
        switch self {
        case .gitHubUsers:
            return "https://api.github.com/users"
        case .gitHubUser(let name):
            return String(format: "https://api.github.com/users/%@", name)
        }
    }
}

class NetworkManager {
    //static let shared = NetworkManager()
    var operationQueue: OperationQueue {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 3
        return operationQueue
    }
    
    let dispatchGroup = DispatchGroup()
    
    init() {
        
    }
    
    func GETcall(api: String, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: URL(string: api)!) { (data, response, error) in
            completion(data, error)
        }
        task.resume()
    }
    
    func GETcallUseCache(api: String, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        var request = URLRequest(url: URL(string: api)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 20.0)
        
        request.addValue(AppData.shared.userName!, forHTTPHeaderField: "my_username")
        request.addValue(AppData.shared.password!, forHTTPHeaderField: "Anil@cocoa1")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let str = String(bytes: data, encoding: .utf8) {
                print(str)
            }
            completion(data, error)
        }
        task.resume()
    }
    
//    func GETcallInsideQueues(api: String, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
//        operationQueue.addOperation {
//            self.GETcallUseCache(api: api, completion: { (data, error) in
//                completion(data, error)
//            })
//        }
//    }
}
