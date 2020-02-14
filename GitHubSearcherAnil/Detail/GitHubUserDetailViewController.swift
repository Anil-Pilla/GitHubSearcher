//
//  GitHubUserDetailViewController.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 13/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation
import UIKit



class GitHubUserDetailViewController: UIViewController {
    
    @IBOutlet weak var imgAvtar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblJoinDate: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var searchRepo: UISearchBar!
    @IBOutlet weak var tblRepos: UITableView!
    
    var loginName: String?
    let viewModel = GitHubUserDetailViewModel()
    var searchString: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = loginName ?? nil
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblRepos.estimatedRowHeight = 100
        tblRepos.rowHeight = UITableView.automaticDimension
    }
    
    func loadData() {
        guard let loginName = loginName else {return}
        weak var weakSelf = self
        viewModel.loadUser(userName: loginName) { (isSuccess, errorMessage) in
            DispatchQueue.main.async {
                if let user = weakSelf?.viewModel.user {
                    if let avtar = GitHubSearcherViewModel.imageCache.object(forKey: user.login as NSString) {
                        weakSelf?.imgAvtar.image = avtar
                    }
                    weakSelf?.lblUsername.text = user.name
                    weakSelf?.lblEmail.text = user.email
                    weakSelf?.lblLocation.text = user.location
                    //weakSelf?.lblJoinDate.text = user.
                    weakSelf?.lblFollowers.text = String(format: "Followers: %d", user.followers)
                    weakSelf?.lblFollowing.text = String(format: "Following: %d", user.following)
                    weakSelf?.lblBio.text = user.bio
                    
                    weakSelf?.viewModel.getRepos(repos: user.repos_url, completion: { (isSuccess, errorMessage) in
                        self.tblRepos.reloadData()
                    })
                }
            }
        }
    }
}

extension GitHubUserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reposList(searchTerm: searchString).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "GitHubUserDetailTableCell") as? GitHubUserDetailTableCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "GitHubUserDetailTableCell") as? GitHubUserDetailTableCell
        }

        let repo = viewModel.reposList(searchTerm: searchString)[indexPath.row]
        cell?.lblRepoName.text = repo["name"] as? String
        if let forks = repo["forks"] as? Int {
            cell?.lblForks.text = String(format: "%d Forks", forks)
        }
        if let stars = repo["stargazers_count"] as? Int {
            cell?.lblStars.text = String(format: "%d Stars", stars)
        }
        return cell!
    }
}

extension GitHubUserDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        tblRepos.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchString = searchBar.text
        tblRepos.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchString = nil
        tblRepos.reloadData()
    }
}



