//
//  GitHubSearcherTableCell.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 12/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation
import UIKit

class GitHubSearcherTableCell: UITableViewCell {
    @IBOutlet weak var imgAvtar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRepos: UILabel!
    
    func populate(withUser gitHubUser: GitHubUser) {
        lblName.text = gitHubUser.login
        
        //load Image
        if let avtar = GitHubSearcherViewModel.imageCache.object(forKey: gitHubUser.login as NSString) {
            imgAvtar.image = avtar
        } else {
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: gitHubUser.avatar_url), let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        GitHubSearcherViewModel.imageCache.setObject(img, forKey: gitHubUser.login as NSString)
                        self.imgAvtar.image = img
                    }
                }
            }
        }
        
        //load repos
        if gitHubUser.reposCount == nil {
            NetworkManager.shared.GETcallInsideQueues(api: gitHubUser.repos_url) { (data, error) in
                print("error", error ?? "No!")
                if let jsonData = data {
                    do {
                        if let reposArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [AnyObject] {
                            print("Count", reposArray.count)
                            DispatchQueue.main.async {
                                self.lblRepos.text = String(format: "Repo: %d", reposArray.count)
                            }
                        } else {
                            print("No array", 0)
                        }
                    } catch {}
                }
            }
        }
    }
}
