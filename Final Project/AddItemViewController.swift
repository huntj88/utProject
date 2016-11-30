//
//  AddItemViewController.swift
//  Final Project
//
//  Created by Hunt, James V on 11/29/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit


protocol RefreshProtocol {
    func setRefresh()
}

class AddItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {

    //MARK: Properties
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var price: UITextField!
    

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    var selectedImagesArray = [UIImage]()
    
    var delegate:RefreshProtocol?
    
    var userID:Int?
    var apiKey:String?
    var numImagesFinishedUploading:Int = 0
    
    //userID
    //categoryID
    //itemName
    //itemDescription
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
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
        let postString = "userID=\(userID!)&apiKey="+apiKey!+"&categoryID=1&itemName="+itemTitle.text!+"&itemDescription="+itemDescription.text+"&price="+price.text!
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
            
            print(responseString)
            
            for x in 0..<self.selectedImagesArray.count
            {
                self.myImageUploadRequest(x,itemID: responseString)
            }
            
            
            
            //if(responseString=="success")
            //{
                print(self.delegate)
                self.delegate?.setRefresh()

            
            //}
            
            
            
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
    
    @IBAction func cameraAction(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    }
    @IBAction func photoLibraryAction(sender: UIButton) {
        print("Pressed photolibrary Button!")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //selecting image form photo library and appending it to selectedImagesArray
        print("Calling func imagePickerController")
        
        var currentImage : UIImage?
        currentImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        selectedImagesArray.append(currentImage!)
        photoCollectionView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        print("you have added \(currentImage) and your array is \(selectedImagesArray.count)")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImagesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : ItemCollectionViewCell = photoCollectionView.dequeueReusableCellWithReuseIdentifier("takenPhotos", forIndexPath: indexPath) as! ItemCollectionViewCell
        
        cell.itemImage.image = selectedImagesArray[indexPath.row]
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        
        return CGSizeMake(width, width)
    }
    
    
    func myImageUploadRequest(imageIndex: Int,itemID: String)
    {
        
        let myUrl = NSURL(string: "http://138.68.41.247:2996/items/uploadImage");
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [
            "userID"  : String(userID!),
            "apiKey"    : apiKey!,
            "itemID":itemID
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
            self.numImagesFinishedUploading+=1
            
            if self.numImagesFinishedUploading == self.selectedImagesArray.count
            {
                dispatch_async(dispatch_get_main_queue()) {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
            
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
    }
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
