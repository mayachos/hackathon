//
//  QuestionTableViewCell.swift
//  hackathon
//
//  Created by maya on 2021/04/17.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet var user: UILabel!
    @IBOutlet var Title: UILabel!
    @IBOutlet var quesText: UILabel!
    @IBOutlet var ansewerUname: UILabel!
    @IBOutlet var answerText: UILabel!
    @IBOutlet var user_Image: UIImageView!
    
    var buttonTag: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(info: que_cell_info, answer: answer_cell_info) {
        user.text = String(info.user_name)
        Title.text = String(info.Title)
        quesText.text = String(info.comment)
        ansewerUname.text = String(answer.user_name)
        answerText.text = String(answer.comment)
        
        buttonTag = info.id
        print(info.id)
    }
    
    func setQueCell(info: que_cell_info) {
        user.text = String(info.user_name)
        Title.text = String(info.Title)
        quesText.text = String(info.comment)
        
        buttonTag = info.id
    }


}
