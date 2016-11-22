//
//  item.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/21/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import Foundation
class item {
    var name: String = ""
    var itemID: Int = 0
    var description: String = ""
    var userID: Int = 0
    init(name: String, itemID:Int, description: String, userID: Int){
        self.name = name
        self.itemID = itemID
        self.description = description
        self.userID = userID
    }
}