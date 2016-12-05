//
//  SignUpViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/21/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UICollectionViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cellPhone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    
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
        postString+="&address="+address.text!+"&zip="+zipCode.text!+"&username="+username.text!
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
                    
                    
                    //1
                    if let plist = Plist(name: "user") {
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
                        print(plist.getValuesInPlistFile())
                    } else {
                        print("Unable to get Plist")
                    }
                    
                    self.performSegueWithIdentifier("toLogin", sender: nil)
                }
            }
            
            
        }
        task.resume()
        
    }
    
    /*func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://138.68.41.247:2996/users/uploadProfileImage");
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [
            "userID"  : String(userID!),
            "apiKey"    : apiKey!
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(selectedImagesArray[imageIndex], 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        //myActivityIndicator.startAnimating();
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                
                print(json)
                
                dispatch_async(dispatch_get_main_queue(),{
                    //self.myActivityIndicator.stopAnimating()
                    //self.myImageView.image = nil;
                });
                
            }catch
            {
                print(error)
            }
            //self.numImagesFinishedUploading+=1
            
            /*if self.numImagesFinishedUploading == self.selectedImagesArray.count
            {
                dispatch_async(dispatch_get_main_queue()) {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }*/
            
        }
        
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }*/
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
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
/*extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}*/