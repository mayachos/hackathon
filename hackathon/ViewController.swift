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
    
    @IBOutlet weak var signInButton: UIButton!
    var UserDefault = UserDefaults.standard
    var userId: String = ""
    var fullName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        signInButton.layer.cornerRadius = 5.0;
        signInButton.layer.borderColor = #colorLiteral(red: 1, green: 0.9372162223, blue: 0, alpha: 1)
        signInButton.layer.borderWidth = 2.0;
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.userInfo()
        UserDefault.setValue(userId, forKey: "userId")
        UserDefault.setValue(fullName, forKey: "fullName")
        print(userId)
        self.post()
        if Auth.auth().currentUser != nil {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UITabBarController
            self.present(secondViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func googleSignIn(sender: AnyObject) {
        
        if Auth.auth().currentUser == nil {
            GIDSignIn.sharedInstance().signIn()
            self.post()
        }
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! UITabBarController
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
    func userInfo() {
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
            userId = user.uid
            fullName = user.displayName ?? ""
          //let email = user.email
          //let photoURL = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
          // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            fullName = user.profile.name
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
    
    func post() {
        let purl = URL(string: "https://cryptic-gorge-02213.herokuapp.com/user/create")
        var request = URLRequest(url: purl!)
        request.httpMethod = "POST"      // Postリクエストを送る(このコードがないとGetリクエストになる)
        // content-type を application/json に設定する
        //request.addValue("application/json", forHTTPHeaderField: "content-type")
        let str: String = "firebase_uid=\(userId)&name=\(fullName)"
        let myData: Data = str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as Data
        request.httpBody = myData as Data
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])
                print(object)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }


}


