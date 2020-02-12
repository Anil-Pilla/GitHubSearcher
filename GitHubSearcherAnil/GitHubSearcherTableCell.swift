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
    }
}
