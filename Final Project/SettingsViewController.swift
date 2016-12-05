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
                
                //1
                if let plist = Plist(name: "user") {
                    //2
                    let dict = plist.getMutablePlistFile()!
                    dict["userID"] = 0
                    dict["apiKey"] = ""
                    do {
                        try plist.addValuesToPlistFile(dict)
                    } catch {
                        print(error)
                    }
                    //4
                    print("woo")
                    print(plist.getValuesInPlistFile())
                } else {
                    print("Unable to get Plist")
                }
                
                self.performSegueWithIdentifier("toLogin", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "toLogin" {
            print("gen")
            if let nextView: ViewController = segue.destinationViewController as? ViewController{
                print("correct VC, Login Sreen")
                //nextVC.incomingText = self.input.text!
            }
        }
    }
}
