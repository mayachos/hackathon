//
//  ViewController.swift
//  hackathon
//
//  Created by maya on 2021/04/16.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    var userId: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UITabBarController
            self.present(secondViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func googleSignIn(sender: AnyObject) {
        
        if Auth.auth().currentUser == nil {
            GIDSignIn.sharedInstance().signIn()
            
        }
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UITabBarController
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
        }
    }

    //追記部分(デリゲートメソッド)エラー来た時
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print(error.localizedDescription)
    }
    
    


}


