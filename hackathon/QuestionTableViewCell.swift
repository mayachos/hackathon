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
    @IBOutlet var ansewerId: UILabel!
    @IBOutlet var user_Image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(info: que_cell_info) {
        user.text = String(info.user_id)
        Title.text = String(info.Title)
        quesText.text = String(info.comment)
        ansewerId.text = String(info.bestAnswerId)
        
    }

}
