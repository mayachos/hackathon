//
//  AddAnswerViewController.swift
//  hackathon
//
//  Created by maya on 2021/04/18.
//

import UIKit

class AddAnswerViewController: UIViewController {

    var userDefault = UserDefaults.standard
    
    @IBOutlet var answerTextView: UITextView!
    
    var answerText: String!
    var cellTag: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(cellTag!)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func postAnswer() {
        answerText = answerTextView.text!
        
        self.post()
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func post() {
        let userId = userDefault.string(forKey: "userId")
        print(userId!)
        let purl = URL(string: "https://cryptic-gorge-02213.herokuapp.com/questions/answer/create/\(userId!)")
        var request = URLRequest(url: purl!)
        request.httpMethod = "POST"      // Postリクエストを送る(このコードがないとGetリクエストになる)
        // content-type を application/json に設定する
        //request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let str: String = "user_id=\(userId!)&comment=\(answerText!)&question_id=\(cellTag!)"
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
