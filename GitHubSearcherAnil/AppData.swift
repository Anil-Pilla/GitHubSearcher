//
//  AppData.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 14/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation

class AppData {
    static let shared = AppData()
    private init() {}
    
    var userName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "GitHubUsername")
        }
        get {
            return UserDefaults.standard.value(forKey: "GitHubUsername") as? String
        }
    }
    var password: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "GitHubPassword")
        }
        get {
            return UserDefaults.standard.value(forKey: "GitHubPassword") as? String
        }
    }
}
