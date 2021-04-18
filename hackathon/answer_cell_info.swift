//
//  answer_cell_info.swift
//  hackathon
//
//  Created by maya on 2021/04/18.
//

import Foundation

struct answer_cell_info {
    
    var user_name: String
    var ques_id: Int
    var user_id: Int
    var comment: String
    
    init(username: String, user_id:Int, ques_id: Int,  comment: String) {
        
        self.user_name = username
        self.user_id = user_id
        self.ques_id = ques_id
        self.comment = comment
    }
}
