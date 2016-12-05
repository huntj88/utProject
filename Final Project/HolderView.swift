//
//  HolderView.swift
//  Final Project
//
//  Created by Choi, Jin W on 12/4/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

protocol HolderViewDelegate:class {
    func animateLabel()
}

class HolderView: UIView {
    
    var parentFrame :CGRect = CGRectZero
    weak var delegate:HolderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    func expandView() {
        // 1
        backgroundColor = Color.blue
        
        // 2
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)
        
        // 3
        layer.sublayers = nil
        
        // 4
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.frame = self.parentFrame
            }, completion: { finished in
                self.addLabel()
        })
    }
    func addLabel() {
        delegate?.animateLabel()
    }
}
