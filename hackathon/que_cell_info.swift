//
//  que_cell_info.swift
//  hackathon
//
//  Created by maya on 2021/04/17.
//

import Foundation

struct que_cell_info {
    
    var id: Int
    var user_id: Int
    var user_name: String
    var Title: String
    var comment: String
    var bestAnswerId: Int
    
    init(id: Int, user_id:Int, user_name: String, Title: String, comment: String, bestAnswerId: Int) {
        
        self.id = id
        self.user_id = user_id
        self.user_name = user_name
        self.Title = Title
        self.comment = comment
        self.bestAnswerId = bestAnswerId
    }
}
