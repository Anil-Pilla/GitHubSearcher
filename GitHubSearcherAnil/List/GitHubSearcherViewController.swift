//
//  GitHubSearcherViewController.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 12/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import UIKit

class GitHubSearcherViewController: UIViewController {
    @IBOutlet weak var tblUsers: UITableView!
    @IBOutlet weak var lblInfo: UILabel!
    
    let viewModel = GitHubSearcherViewModel()
    var searchString: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !viewModel.isLoggedIn() {
            showLogin()
        }
        loadData()
        showSearchBar()
    }
    
    func showLogin() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func loadData() {
        guard AppData.shared.userName != nil && AppData.shared.password != nil else {return}
        self.lblInfo.text = "Loading users.."
        self.tblUsers.isHidden = true
        weak var weakSelf = self
        viewModel.loadUsers { (isSuccess, errorMessage) in
            DispatchQueue.main.async {
                guard isSuccess else {
                    weakSelf?.lblInfo.text = errorMessage
                    weakSelf?.tblUsers.isHidden = true
                    return
                }
                weakSelf?.lblInfo.text = nil
                weakSelf?.tblUsers.isHidden = false
                weakSelf?.tblUsers.reloadData()
            }
        }
    }
    
    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Search for Users"
        navigationItem.searchController = searchController
    }
    @IBAction func btnLoginAction(_ sender: Any) {
        showLogin()
    }
}

extension GitHubSearcherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        tblUsers.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchString = searchBar.text
        tblUsers.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchString = nil
        tblUsers.reloadData()
    }
}

extension GitHubSearcherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersList(searchTerm: searchString)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "GitHubSearcherTableCell") as? GitHubSearcherTableCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "GitHubSearcherTableCell") as? GitHubSearcherTableCell
        }
        if let user = viewModel.usersList(searchTerm: searchString)?[indexPath.row] {
            cell?.populate(withUser: user)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GitHubUserDetailViewController") as! GitHubUserDetailViewController
        if let user = viewModel.usersList(searchTerm: searchString)?[indexPath.row] {
            vc.loginName = user.login
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
