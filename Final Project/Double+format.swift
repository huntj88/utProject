//
//  Double+format.swift
//  Final Project
//
//  Created by Hunt, James V on 12/4/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import Foundation
extension Double {
    /*func money() -> String {
        return "$"+String(format: "%\(".0")f", self)
    }*/
    
    func money() -> String{
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        return "$" + numberFormatter.stringFromNumber(self)!
    }
}