//
//  QuestionTableViewController.swift
//  hackathon
//
//  Created by maya on 2021/04/17.
//

import UIKit

class QuestionTableViewController: UITableViewController {
    
    
    var cellData = [que_cell_info]()
    var answerData = [[answer_cell_info]]()
    var questionCount = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.questionGet()
        self.AnswerGet()
        
        // cellData.append(que_cell_info(user_id: user_Id, Title: Title, comment: comment, bestAnswerId: answerId))
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func questionGet() {
        let url: URL = URL(string: "https://cryptic-gorge-02213.herokuapp.com/questions/all")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            print("data: \(data)")
            print("response: \(response)")
            print("error: \(error)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                print(json)
                //(D) Any型の配列に変換したものを、[String: Any]の辞書型にダウンキャスト
                let ques = json.map { (ques) -> [String: Any] in
                    return ques as! [String: Any]
                }
                
                // (E) 記事の総数をcountと定義する
                let count = ques.count
                self.questionCount = count
                
             
                // (F) for文で各記事のtitleを抜き出し、titleArray配列に追加
                for i in 0..<count {
                    var id = 0
                    if ques[i]["id"] != nil {
                        id = ques[i]["id"] as! Int
                    }
                    var userid = 0
                    if ques[i]["user_id"] != nil {
                        userid = ques[i]["user_id"] as! Int
                    }
                    var username = ""
                    if ques[i]["user_name"] != nil {
                        username = ques[i]["user_name"] as? String ?? ""
                    }
                    var title = ""
                    if ques[i]["title"] != nil {
                        title = ques[i]["title"] as? String ?? ""
                    }
                    var text = ""
                    if ques[i]["comment"] != nil{
                        text = ques[i]["comment"] as? String ?? ""
                    }
                    var answer = 0
                    if ques[i]["bestanswer_id"] != nil{
                        answer = ques[i]["bestanswer_id"] as! Int
                    }
//                    let answerid = ques[i]["bestanswer_id"] as! Int
//                    self.answerId.append(answerid)
                    print(title)
                    self.cellData.append(que_cell_info(id: id, user_id: userid, user_name: username, Title: title, comment: text, bestAnswerId: answer))
                }
                DispatchQueue.main.async() { () -> Void in
                    self.tableView.reloadData()
                }
            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
    
    func AnswerGet() {
        for j in 1..<questionCount {
            let url: URL = URL(string: "https://cryptic-gorge-02213.herokuapp.com/questions/answer/\(j)")!
            let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                print("data: \(data)")
                print("response: \(response)")
                print("error: \(error)")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                    print(json)
                    //(D) Any型の配列に変換したものを、[String: Any]の辞書型にダウンキャスト
                    let ans = json.map { (ans) -> [String: Any] in
                        return ans as! [String: Any]
                    }
                    
                    
                    // (E) 記事の総数をcountと定義する
                    let count = ans.count
                    
                    // (F) for文で各記事のtitleを抜き出し、titleArray配列に追加
                    for i in 0..<count {
                        var que_id = 0
                        if ans[i]["question_id"] != nil {
                            que_id = ans[i]["question_id"] as! Int
                        }
                        var userid = 0
                        if ans[i]["user_id"] != nil {
                            userid = ans[i]["user_id"] as! Int
                        }
                        var username = ""
                        if ans[i]["user_name"] != nil {
                            username = ans[i]["user_name"] as? String ?? ""
                        }
                        var text = ""
                        if ans[i]["comment"] != nil{
                            text = ans[i]["comment"] as? String ?? ""
                        }
                        print(que_id)
                        //                    let answerid = ques[i]["bestanswer_id"] as! Int
                        //                    self.answerId.append(answerid)
                        self.answerData[j].append(answer_cell_info(username: username, user_id: userid, ques_id: que_id, comment: text))
                    }
                    DispatchQueue.main.async() { () -> Void in
                        self.tableView.reloadData()
                    }
                }
                catch {
                    print(error)
                }
            })
            task.resume()
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! QuestionTableViewCell
        
        cell.layer.cornerRadius = 5.0
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0.3294117647, blue: 0.5921568627, alpha: 1)
        if !answerData.isEmpty {
        cell.setCell(info: cellData[indexPath.row], answer: answerData[0][0])
        } else {
            cell.setQueCell(info: cellData[indexPath.row])
        }
        
        // Configure the cell...
        
        return cell
    }
    
    @IBAction func answer(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "answerStoryBoard") as! AddAnswerViewController
        nextVC.cellTag = QuestionTableViewCell().buttonTag
        print(QuestionTableViewCell().buttonTag)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
