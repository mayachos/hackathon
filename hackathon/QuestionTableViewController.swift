//
//  QuestionTableViewController.swift
//  hackathon
//
//  Created by maya on 2021/04/17.
//

import UIKit

class QuestionTableViewController: UITableViewController {
    
    var user_Id: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    var Title: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    var comment: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    var answerId: Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    var cellData = [que_cell_info]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

                let url: URL = URL(string: "https://evening-dawn-10921.herokuapp.com/test/:contents")!
                let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                       print("data: \(data)")
                       print("response: \(response)")
                       print("error: \(error)")
        
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                        print(json)
                        // (D) Any型の配列に変換したものを、[String: Any]の辞書型にダウンキャスト
        //                       let tips = json.map { (tips) -> [String: Any] in
        //                           return tips as! [String: Any]
        //                       }
        //
        //                // (E) 記事の総数をcountと定義する
        //                let count = tips.count
        //
        //
        //                                // (F) for文で各記事のtitleを抜き出し、titleArray配列に追加
        //                for i in 0...count-1 {
        //                            let userid = tips[i]["user_id"] as! String
        //                            self.user_Id.append(userid)
        //                            let title = tips[i]["title"] as! String
        //                            self.Title.append(title)
        //                            let text = tips[i]["comment"] as! String
        //                            self.Title.append(text)
        //                            print(title)
        //                            self.cellData.append(tips_cell_info(user_id: userid, title: title, comment: text))
        //                                }
        //                DispatchQueue.main.async() { () -> Void in
        //                    self.tableView.reloadData()
        //                }
                    }
                    catch {
                        print(error)
                    }
                   })
                task.resume()

        cellData.append(que_cell_info(user_id: user_Id, Title: Title, comment: comment, bestAnswerId: answerId))
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.setCell(info: cellData[indexPath.row])

        // Configure the cell...

        return cell
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
