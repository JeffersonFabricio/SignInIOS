//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by aluno on 17/09/20.
//  Copyright © 2020 CESAR School. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    
    var name : String?
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var signIn: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        login.text = getLogin()
    }
    
    func getLogin() -> String {
        let preferences = UserDefaults.standard
        if preferences.string(forKey: "login_token") != nil {
            let login_token = preferences.string(forKey: "login_token")
            return login_token!
        } else {
            return ""
        }
    }


}

extension ViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let name = user?.profile.name {
            saveLogin(loginToken: name)
        }
    }
    
    func saveLogin(loginToken: String?){
        let preferences = UserDefaults.standard
        print("saveLoginToken : \(loginToken!)")
        preferences.set(loginToken, forKey: "login_token")
        // Checking the preference is saved or not
        didSave(preferences: preferences)
        login.text = loginToken
    }
    
    func didSave(preferences: UserDefaults){
        let didSave = preferences.synchronize()
        if !didSave{
            print("Preferences could not be saved!")
        }
    }
}


