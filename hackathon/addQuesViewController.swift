//
//  addQuesViewController.swift
//  hackathon
//
//  Created by maya on 2021/04/18.
//

import UIKit

class addQuesViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var quesTextView: UITextView!
    
    var userdefault = UserDefaults.standard
    
    var titleText: String = ""
    var quesText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // 枠のカラー
        quesTextView.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.368627451, blue: 0.6392156863, alpha: 1)
        
        // 枠の幅
        quesTextView.layer.borderWidth = 5.0
        
        // 枠を角丸にする
        quesTextView.layer.cornerRadius = 20.0
        quesTextView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func postButton() {
        titleText = titleTextField.text!
        quesText = quesTextView.text!
        
        self.post()
        dismiss(animated: true, completion: nil)
    }

    func post() {
        let userid = userdefault.string(forKey: "userId")
        
        let purl = URL(string: "https://cryptic-gorge-02213.herokuapp.com/questions/create/\(userid!)")
        var request = URLRequest(url: purl!)
        request.httpMethod = "POST"      // Postリクエストを送る(このコードがないとGetリクエストになる)
        // content-type を application/json に設定する
        //request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let str: String = "user_id=\(userid!)&title=\(titleText)&comment=\(quesText)"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
