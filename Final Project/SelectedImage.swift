//
//  SelectedImage.swift
//  Final Project
//
//  Created by Choi, Jin W on 12/5/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class SelectedImage: UIViewController {
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    var pic : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDisplay.image = pic!
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
