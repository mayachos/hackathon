//
//  TipsTableViewCell.swift
//  hackathon
//
//  Created by maya on 2021/04/16.
//

import UIKit

class TipsTableViewCell: UITableViewCell {
    
    @IBOutlet var user: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var tipsText: UILabel!
    @IBOutlet var user_Image: UIImageView!
    
    var id = 0
    
    @IBOutlet var goodButton: UIButton!
    var userDefault = UserDefaults.standard
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(info: tips_cell_info) {
        let heart = UIImage(named: "notheart")
        goodButton.setImage(heart, for: .normal)
        user.text = String(info.user_name)
        title.text = String(info.title)
        tipsText.text = String(info.comment)
        id = info.id
    }
    
    @IBAction func goodB() {
        let image = UIImage(named: "heart")
        goodButton.setImage(image, for: .normal)
        
        self.post()
    }
    
    func post() {
        let userId = userDefault.string(forKey: "userId")
        print(userId!)
        let purl = URL(string: "https://cryptic-gorge-02213.herokuapp.com/tips/like/\(userId!)")!
        var request = URLRequest(url: purl)
        request.httpMethod = "POST"      // Postリクエストを送る(このコードがないとGetリクエストになる)
        print(id)
        let str: String = "user_id=\(userId!)&tips_id=\(id)"
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
