//
//  ViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/14/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://138.68.41.247:2996/users/login")!)
        request.HTTPMethod = "POST"
        //let postString = "email=huntj88@gmail.com&password=test"
        let postString = "email="+email.text!+"&password="+password.text!
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
        
            
            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)!
            print("responseString = \(responseString)")
            
            let json: AnyObject? = responseString.parseJSONString
            
            if let item = json![0] as? [String: AnyObject] {
                if let email = item["email"] as? String {
                    print(email)
                    NSOperationQueue.mainQueue().addOperationWithBlock
                        {
                        self.performSegueWithIdentifier("loginSeg", sender: nil)
                        print ("let's gooo!")
                    }
                }
            }
            
            
        }
        task.resume()
        
        
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
