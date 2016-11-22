//
//  SignUpViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/21/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var cellPhone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var aptNumber: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var fullName: UITextField!
    
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
    
    @IBAction func SignUp(sender: AnyObject) {
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://138.68.41.247:2996/users/register")!)
        request.HTTPMethod = "POST"
        //let postString = "email=huntj88@gmail.com&password=test"
        var postString = "email="+email.text!+"&password="+password.text!+"&phone="+cellPhone.text!
        postString+="&address="+address.text!+"&zip="+zipCode.text!+"&apt="+aptNumber.text!
        postString+="&city="+city.text!+"&name="+fullName.text!
        
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
                    //print("\(self.userID!)  "+self.apiKey!)
                    print(self.userID!)
                    print(self.apiKey!)
                    self.performSegueWithIdentifier("toLogin", sender: nil)
                }
            }
            
            
        }
        task.resume()
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
