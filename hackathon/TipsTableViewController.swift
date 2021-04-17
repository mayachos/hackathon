//
//  TipsTableViewController.swift
//  hackathon
//
//  Created by maya on 2021/04/16.
//

import UIKit

class TipsTableViewController: UITableViewController {
    var user_Id: [Int] = []
    var Title: [String] = []
    var comment: [String] = []
    
    
    var cellData = [tips_cell_info]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 10))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        self.navigationController?.navigationBar.backIndicatorImage = image
        
        
        let url: URL = URL(string: "https://evening-dawn-10921.herokuapp.com/tips/all")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            print("data: \(data)")
            print("response: \(response)")
            print("error: \(error)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                print(json)
                // (D) Any型の配列に変換したものを、[String: Any]の辞書型にダウンキャスト
                let tips = json.map { (tips) -> [String: Any] in
                    return tips as! [String: Any]
                }
                
                // (E) 記事の総数をcountと定義する
                let count = tips.count
                // (F) for文で各記事のtitleを抜き出し、titleArray配列に追加
                for i in 0..<count{
                    var userid = 0
                    if tips[i]["id"] != nil {
                        userid = tips[i]["id"] as! Int
                        self.user_Id.append(userid)
                    }
                    var title = ""
                    if tips[i]["title"] != nil {
                        title = tips[i]["title"] as? String ?? ""
                        self.Title.append(title)
                    }
                    var text = ""
                    if tips[i]["comment"] != nil{
                        text = tips[i]["comment"] as? String ?? ""
                        self.comment.append(text)
                    }
                    self.cellData.append(tips_cell_info(user_id: userid, title: title, comment: text))
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           return 10 // セルの下部のスペース
       }
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TipsTableViewCell
        
        
        cell.layer.cornerRadius = 5.0
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = #colorLiteral(red: 0.3470362425, green: 0.7739748359, blue: 0.7306001782, alpha: 1)
        cell.setCell(info: cellData[indexPath.row])
        // Configure the cell...
        
        return cell
    }
    
    @IBAction func goodButton() {
        
        self.post()
    }
    
    func post() {
        let VC = ViewController()
        let purl = URL(string: "https://evening-dawn-10921.herokuapp.com/tips/replies/:tips_id")!
        var request = URLRequest(url: purl)
        request.httpMethod = "POST"      // Postリクエストを送る(このコードがないとGetリクエストになる)
        request.httpBody = "user_id=\(VC.userId)".data(using: .utf8)
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
