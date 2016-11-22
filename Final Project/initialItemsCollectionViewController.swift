//
//  initialItemsCollectionViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/21/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class initialItemsCollectionViewController: UICollectionViewController {

    
    var userID:Int?
    var apiKey:String?
    var items = [item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserInfo()
        
        
        
        
        
        

        let request = NSMutableURLRequest(URL: NSURL(string: "http://138.68.41.247:2996/items/getByCategory")!)
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
            print("responseString = \(responseString)")
            
            
            let json: AnyObject? = responseString.parseJSONString
            
            var i = 0
            while(i<1)
            {
                if let jsonItem = json![i] as? [String: AnyObject] {
                    /*self.userID = jsonItem["userID"] as? Int
                    self.apiKey = jsonItem["apiKey"] as? String
                    //print("\(self.userID!)  "+self.apiKey!)
                    print(self.userID!)
                    print(self.apiKey!)*/
                    let objectThing:item = item(name: (jsonItem["itemName"] as? String)!,itemID: (jsonItem["itemID"] as? Int)!,description: (jsonItem["itemDescription"] as? String)!,userID: (jsonItem["userID"] as? Int)!)
                    
                    self.items.append(objectThing)
                }
                i+=1
                print(self.items.count)

                
            }
            
            
            
            
            

            
            
        }
        task.resume()
        
        
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
