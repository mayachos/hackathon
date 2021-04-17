//
//  tips_cell_Info.swift
//  hackathon
//
//  Created by maya on 2021/04/16.
//

import Foundation

struct tips_cell_info {
    
    var user_id: String
    var title: String
    var comment: String
    
    init(user_id:String, title: String, comment: String) {
        
        self.user_id = user_id
        self.title = title
        self.comment = comment
    }
    
}
