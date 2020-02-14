//
//  LoginViewController.swift
//  GitHubSearcherAnil
//
//  Created by Nanduri on 13/02/20.
//  Copyright © 2020 An. All rights reserved.
//

import Foundation
import UIKit


class LoginViewController: UIViewController {
    
    let sreviceName: String = "GitHubSearcherAnil"
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.text = AppData.shared.userName
    }
    @IBAction func btnCancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnDoneAction(_ sender: Any) {
        guard let un = txtUsername.text, let pwd = txtPassword.text, un.count > 0 && pwd.count > 0 else {
            let alert = UIAlertController(title: "Provide Username & Password", message: nil, preferredStyle: .alert)
            let acton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(acton)
            self.present(alert, animated: true, completion: nil)
            return
        }
        AppData.shared.userName = un
        AppData.shared.password = pwd
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func deletePreviousGitHubCredentials() {
        
    }
    
    func saveGitHubCredentials() {
        
    }
}
