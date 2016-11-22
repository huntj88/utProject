//
//  ViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/14/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        performSegueWithIdentifier("loginSeg", sender: nil)
        print ("let's gooo!")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "loginSeg" {
            print("gen")
            if let nextView: initialItemScreenCollectionViewController = segue.destinationViewController as? initialItemScreenCollectionViewController{
                print("correct VC, second screen")
                //nextVC.incomingText = self.input.text!
                
            }
        }
        if segue.identifier == "toItem"{
            print("toItem")
            if let nextView: initialItemScreenCollectionViewController = segue.destinationViewController as? initialItemScreenCollectionViewController{
                print("correct VC, second screen")
            }
        }
    }
}
