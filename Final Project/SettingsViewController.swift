//
//  SettingsViewController.swift
//  Final Project
//
//  Created by Hunt, James V on 12/4/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPopoverPresentationControllerDelegate{


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    @IBAction func logout(sender: AnyObject) {
        
        NSOperationQueue.mainQueue().addOperationWithBlock
            {
                
                self.logoutUser()
                
                self.performSegueWithIdentifier("toLogin", sender: nil)
        }
        
    }
    @IBAction func inviteFriends(sender: UIButton) {
        
        self.performSegueWithIdentifier("toInviteFriends", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == "toLogin" {
            print("gen")
            if var _ : ViewController = segue.destinationViewController as? ViewController{
                print("correct VC, Login Sreen")
            }
        }
        if segue.identifier == "toInviteFriends" {
            let vc = segue.destinationViewController
            vc.popoverPresentationController?.delegate = self
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return UIModalPresentationStyle.None
    }

}
