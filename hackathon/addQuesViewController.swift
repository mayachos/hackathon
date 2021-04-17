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
    
    var titleText: String = ""
    var urlText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func postButton() {
        titleText = titleTextField.text!
        urlText = quesTextView.text!
        
        
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

}
