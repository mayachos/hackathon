//
//  AddTipsViewController.swift
//  hackathon
//
//  Created by maya on 2021/04/17.
//

import UIKit

class AddTipsViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var urlTextField: UITextField!
    
    var titleText: String = ""
    var urlText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func postButton() {
        titleText = titleTextField.text!
        urlText = urlTextField.text!
        
        self.post()
        
        dismiss(animated: true, completion: nil)
    }
    
    func post() {
        let VC = ViewController()
        let purl = URL(string: "https://cryptic-gorge-02213.herokuapp.com/tips/create/\(VC.userId)")
        var request = URLRequest(url: purl!)
        request.httpMethod = "POST"      // Postリクエストを送る(このコードがないとGetリクエストになる)
        // content-type を application/json に設定する
        //request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let str: String = "user_id=\(VC.userId)&title=\(titleText)&comment=\(urlText)"
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
