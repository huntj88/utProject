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
    
    var userID:Int?
    var apiKey:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        /*if let plist = Plist(name: "user") {
            let dict = plist.getValuesInPlistFile()
            if (dict!["userID"]! as? Int) != 0
            {
                print("login")
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    [weak self] in
                    self?.performSegueWithIdentifier("loginSeg", sender: self)
                }
            }
        } else {
            print("Unable to get Plist")
        }*/
        userID = getUserID()
        apiKey = getApiKey()
        
        if(userID != 0)
        {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                [weak self] in
                self?.performSegueWithIdentifier("loginSeg", sender: self)
            }
        }
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
                NSOperationQueue.mainQueue().addOperationWithBlock
                    {
                        self.userID = item["userID"] as? Int
                        self.apiKey = item["apiKey"] as? String
                        let imageName = item["imageName"] as? String
                        self.saveInfo((item["userID"] as? Int)!, apiKey: (item["apiKey"] as? String)!,imageName: imageName!)
                        //print("\(self.userID!)  "+self.apiKey!)
                        print(self.userID!)
                        print(self.apiKey!)
                        
                        
                        //1
                        /*if let plist = Plist(name: "user") {
                            //2
                            let dict = plist.getMutablePlistFile()!
                            dict["userID"] = self.userID!
                            dict["apiKey"] = self.apiKey!
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
                        }*/
                        
                        self.performSegueWithIdentifier("loginSeg", sender: nil)
                }
            }
            
            
        }
        task.resume()
        
        
    }
    
    
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "loginSeg" {
            print("gen")
            if let _: initialItemScreenCollectionViewController = segue.destinationViewController as? initialItemScreenCollectionViewController{
                print("correct VC, second screen")
                //nextVC.incomingText = self.input.text!
                
            }
        }
    }
}
