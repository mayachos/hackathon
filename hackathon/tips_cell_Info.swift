//
//  tips_cell_Info.swift
//  hackathon
//
//  Created by maya on 2021/04/16.
//

import Foundation

class tips_cell_info: NSObject {
    
    var user_id: Int
    var category_id: Int
    var comment: String
    
    init(user_id:Int, category_id: Int, comment: String) {
        
        self.user_id = user_id
        self.category_id = category_id
        self.comment = comment
    }
}
