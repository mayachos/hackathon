//
//  que_cell_info.swift
//  hackathon
//
//  Created by maya on 2021/04/17.
//

import Foundation

struct que_cell_info {
    
    var user_id: String
    var Title: String
    var comment: String
    var bestAnswerId: Int
    
    init(user_id:String, Title: String, comment: String, bestAnswerId: Int) {
        
        self.user_id = user_id
        self.Title = Title
        self.comment = comment
        self.bestAnswerId = bestAnswerId
    }
}
