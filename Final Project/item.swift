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
    var categoryID: Int = 0
    var itemName: String = ""
    var categoryName: String = ""
    var price: Double = 0.0
    var imageNames:String = ""
    var email: String = ""
    var userImage = ""
    
    init(name: String, itemID:Int, description: String, userID: Int, categoryID: Int, itemName: String, categoryName: String, price:Double, imageNames:String, email:String, userImage:String){
        self.name = name
        self.itemID = itemID
        self.description = description
        self.userID = userID
        self.categoryID = categoryID
        self.itemName = itemName
        self.categoryName = categoryName
        self.price=price
        self.imageNames = imageNames
        self.email = email
        self.userImage = userImage
        
    }
}