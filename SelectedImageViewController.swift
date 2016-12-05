//
//  SelectedImageViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 12/5/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class SelectedImageViewController: UIViewController {

    @IBOutlet weak var imageDisplay: AsyncImageView!
    
    var pic :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDisplay.loadImageUsingUrlString("http://138.68.41.247:2996/items/image/"+pic!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
