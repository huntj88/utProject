//
//  initialItemsCollectionViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/21/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell1"
class initialItemsCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,RefreshProtocol {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var refresh: Bool = false
    
    var userID:Int?
    var apiKey:String?
    var items = [item]()
    //var myCollectionView:UICollectionView?
    var selectedItemName: String = ""
    var indexOfItem:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInfo()
        loadDataFromServer()
        
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(refresh)
        if refresh == true
        {
            items.removeAll()
            loadDataFromServer()
            refresh = false
        }
    }
    
    func setRefresh() {
        print("refresh set")
        refresh=true
    }
    
    @IBAction func addItemButton(sender: AnyObject) {
        performSegueWithIdentifier("addItemSegue", sender: UICollectionViewCell())
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return items.count
    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:ItemCollectionViewCell = myCollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ItemCollectionViewCell
        
        cell.itemName.text = items[indexPath.row].itemName
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        selectedItemName = items[indexPath.row].name
        indexOfItem = indexPath.row
        performSegueWithIdentifier("toItemDescriptionView", sender: UICollectionViewCell())
        print("You selected cell #\(indexPath.item) named \(selectedItemName)!")
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
        else if segue.identifier == "addItemSegue" {
            if let nextView: AddItemViewController = segue.destinationViewController as? AddItemViewController{
                nextView.delegate = self
            }
        }
    }

}