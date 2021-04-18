//
//  answer_cell_info.swift
//  hackathon
//
//  Created by maya on 2021/04/18.
//

import Foundation

struct answer_cell_info {
    
    var id: Int
    var ques_id: Int
    var user_id: Int
    var Title: String
    var comment: String
    var bestAnswerId: Int
    
    init(id: Int, user_id:Int, ques_id: Int, Title: String, comment: String, bestAnswerId: Int) {
        
        self.id = id
        self.user_id = user_id
        self.ques_id = ques_id
        self.Title = Title
        self.comment = comment
        self.bestAnswerId = bestAnswerId
    }
}
