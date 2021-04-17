//
//  TipsTableViewCell.swift
//  hackathon
//
//  Created by maya on 2021/04/16.
//

import UIKit

class TipsTableViewCell: UITableViewCell {
    
    @IBOutlet var user: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var tipsText: UILabel!
    @IBOutlet var user_Image: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(info: tips_cell_info) {
        user.text = String(info.user_id)
        category.text = String(info.category_id)
        tipsText.text = String(info.comment)
    }

}
