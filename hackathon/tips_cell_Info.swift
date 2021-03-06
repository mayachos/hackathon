//
//  tips_cell_Info.swift
//  hackathon
//
//  Created by maya on 2021/04/16.
//

import Foundation

struct tips_cell_info {
    
    var id: Int
    var user_id: String
    var user_name: String
    var title: String
    var comment: String
    var category: String
    
    init(id: Int, user_id:String, username: String, title: String, comment: String, category: String) {
        
        self.id = id
        self.user_id = user_id
        self.title = title
        self.comment = comment
        self.user_name = username
        self.category  = category
    }
    
}
