//
//  AddItemViewController.swift
//  Final Project
//
//  Created by Hunt, James V on 11/29/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemDescription: UITextView!
    
    var userID:Int?
    var apiKey:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitItem(sender: AnyObject) {
        
        loadUserInfo()
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://138.68.41.247:2996/items/add")!)
        request.HTTPMethod = "POST"
        //let postString = "email=huntj88@gmail.com&password=test"
        let postString = "userID=\(userID!)&apiKey="+apiKey!+"&categoryID=1"
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
            
            
        }
        
        
        
        
        
        task.resume()
    }
    
    
    func loadUserInfo()
    {
        
        if let plist = Plist(name: "user") {
            let dict = plist.getValuesInPlistFile()
            if (dict!["userID"]! as? Int) != 0
            {
                userID = dict!["userID"] as? Int
                apiKey = dict!["apiKey"] as? String
                /*NSOperationQueue.mainQueue().addOperationWithBlock {
                 [weak self] in
                 self?.performSegueWithIdentifier("loginSeg", sender: self)
                 }*/
            }
        } else {
            print("Unable to get Plist")
        }
        
        
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
