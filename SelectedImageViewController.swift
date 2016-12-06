//
//  SelectedImageViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 12/5/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class SelectedImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageDisplay: AsyncImageView!
    
    var pic :String?
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 8.0
        
        imageDisplay.loadImageUsingUrlString("http://138.68.41.247:2996/items/image/"+pic!)
        background.image = imageDisplay.image
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageDisplay
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
