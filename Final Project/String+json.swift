//
//  String+json.swift
//  Final Project
//
//  Created by Jin Won Choi on 11/21/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import Foundation

extension String {
    
    var parseJSONString: AnyObject? {
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            
            do{
                return try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
            }catch{
                print("json failed")
                return nil
            }
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}