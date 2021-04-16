//
//  que_cell_info.swift
//  hackathon
//
//  Created by maya on 2021/04/17.
//

import Foundation

class que_cell_info: NSObject {
    
    var user_id: Int
    var category_id: Int
    var comment: String
    var bestAnswerId: Int
    
    init(user_id:Int, category_id: Int, comment: String, bestAnswerId: Int) {
        
        self.user_id = user_id
        self.category_id = category_id
        self.comment = comment
        self.bestAnswerId = bestAnswerId
    }
}
