//
//  CategoriesViewController.swift
//  Final Project
//
//  Created by Hunt, James V on 11/28/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    var userID:Int?
    var apiKey:String?
    var categories = [Category]()
    var indexOfCategory:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userID = getUserID()
        apiKey = getApiKey()
        
        
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://138.68.41.247:2996/items/getCategories")!)
        request.HTTPMethod = "POST"
        //let postString = "email=huntj88@gmail.com&password=test"
        let postString = "userID=\(userID!)&apiKey="+apiKey!
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
                    let objectThing:Category = Category(name: (jsonItem["categoryName"] as? String)!,categoryID: (jsonItem["categoryID"] as? Int)!)
                    
                    self.categories.append(objectThing)
                }
                i+=1
                print(self.categories.count)
                
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.myTableView.reloadData()
            }
            
        }
        
        
        print(categories.count)
        
        
        
        task.resume()
        

        myTableView.dataSource = self
        myTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! CategoryTableViewCell
        
        cell.categoryName.text = categories[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        indexOfCategory = indexPath.row
        performSegueWithIdentifier("itemCategorySegue", sender: UICollectionViewCell())
    }

    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "itemCategorySegue" {
            if let nextView: ItemCategoryViewController = segue.destinationViewController as? ItemCategoryViewController{
                nextView.myCategory = categories[indexOfCategory]
            }
        }
    }
}
