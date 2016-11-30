//
//  ItemCategoryViewController.swift
//  Final Project
//
//  Created by Hunt, James V on 11/29/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class ItemCategoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    var userID:Int?
    var apiKey:String?
    var items = [item]()
    var indexOfItem:Int = 0
    var myCategory:Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserInfo()
        loadDataFromServer()
        
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func loadDataFromServer()
    {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://138.68.41.247:2996/items/getByCategory")!)
        request.HTTPMethod = "POST"
        //let postString = "email=huntj88@gmail.com&password=test"
        let postString = "userID=\(userID!)&apiKey="+apiKey!+"&categoryID="+String((myCategory?.categoryID)!)
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
            
            
            let json: AnyObject? = responseString.parseJSONString
            
            var i = 0
            
            while(i<json?.count)
            {
                
                if let jsonItem = json![i] as? [String: AnyObject] {
                    /*self.userID = jsonItem["userID"] as? Int
                     self.apiKey = jsonItem["apiKey"] as? String
                     //print("\(self.userID!)  "+self.apiKey!)
                     print(self.userID!)
                     print(self.apiKey!)*/
                    let objectThing:item = item(name: (jsonItem["username"] as? String)!,itemID: (jsonItem["itemID"] as? Int)!,description: (jsonItem["itemDescription"] as? String)!,userID: (jsonItem["userID"] as? Int)!,categoryID: (jsonItem["categoryID"] as? Int)!,itemName: (jsonItem["itemName"] as? String)!,categoryName: (jsonItem["categoryName"] as? String)!,price: (jsonItem["price"] as? Double)!)
                    
                    self.items.append(objectThing)
                }
                i+=1
                print(self.items.count)
                
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.myCollectionView.reloadData()
            }
            
        }
        
        
        print(items.count)
        
        
        
        task.resume()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:ItemCollectionViewCell = myCollectionView.dequeueReusableCellWithReuseIdentifier("categoryItemCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        
        cell.itemName.text = items[indexPath.row].itemName
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        indexOfItem = indexPath.row
        performSegueWithIdentifier("toItemDescriptionView", sender: UICollectionViewCell())
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "toItemDescriptionView" {
            print("toItemDescriptionSeg executed!")
            if let nextView: ItemDescriptionViewController = segue.destinationViewController as? ItemDescriptionViewController{
                print("correct VC, ItemDescription Screen")
                nextView.myItem = items[indexOfItem]
                //print(items[indexOfItem].categoryID)
                nextView.userImagePhoto = UIImage(named: "Background")!
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
