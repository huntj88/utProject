//
//  SettingsViewController.swift
//  Final Project
//
//  Created by Hunt, James V on 12/4/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func logout(sender: AnyObject) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock
            {
                
                self.logoutUser()
                
                self.performSegueWithIdentifier("toLogin", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "toLogin" {
            print("gen")
            if let _: ViewController = segue.destinationViewController as? ViewController{
                print("correct VC, Login Sreen")
                //nextVC.incomingText = self.input.text!
            }
        }
    }
}
