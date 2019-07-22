//
//  LoginViewController.swift
//  VFChallengeTPV
//
//  Created by Teresa on 21/07/2019.
//  Copyright © 2019 Teresa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NSURLConnectionDelegate {

    @IBOutlet weak var userUIText: UITextField!
    @IBOutlet weak var passUIText: UITextField!
    @IBOutlet weak var messageUILabel: UILabel!
    
    @IBAction func tappedLoginButton(_ sender: Any) {
        let user = userUIText.text ?? ""
        let password = passUIText.text ?? ""
        
        if (user.isEmpty) || (password.isEmpty){
            messageUILabel.text = "Username or password incorrect"
        } else {
            login(user: user, password: password)
        }
    }
    
    func login(user: String, password: String) {
        
        guard let url = URL(string: "https://api.github.com") else { return }
        
        let task = getUrlSession(user: user, password: password).dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showRepositories", sender: self)
                }
            } else{
                DispatchQueue.main.async {
                    self.messageUILabel.text = "Username or password incorrect"
                }
            }
        }
        task.resume()
    }
}
