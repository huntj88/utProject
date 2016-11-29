//
//  CategoryTableViewCell.swift
//  Final Project
//
//  Created by Hunt, James V on 11/28/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
