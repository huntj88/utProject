//
//  ViewController+stuff.swift
//  Final Project
//
//  Created by Hunt, James V on 12/4/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import Foundation
import UIKit
import CoreData
extension UIViewController{
    
    func saveInfo(userID: Int,apiKey: String,imageName:String) {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("UserInfo",
                                                        inManagedObjectContext:managedContext)
        
        let userInfo = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        userInfo.setValue(userID, forKey: "userID")
        userInfo.setValue(apiKey, forKey: "apiKey")
        userInfo.setValue(imageName, forKey: "imageName")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    func getUserID() -> Int {
        var info = [NSManagedObject]()
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "UserInfo")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            info = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return 0
        }
        
        if(info.count==0)
        {
            return 0
        }
        
        let oneInfo = info[0]
        return oneInfo.valueForKey("userID") as! Int
        //return info[0].valueForKey("userID")
    }
    
    func getApiKey() -> String {
        var info = [NSManagedObject]()
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "UserInfo")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            info = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return ""
        }
        
        if(info.count==0)
        {
            return ""
        }
        
        let oneInfo = info[0]
        return oneInfo.valueForKey("apiKey") as! String
        //return info[0].valueForKey("userID")
    }
    
    
    func getUserImage() -> String {
        var info = [NSManagedObject]()
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "UserInfo")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            info = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return ""
        }
        
        if(info.count==0)
        {
            return ""
        }
        
        let oneInfo = info[0]
        return oneInfo.valueForKey("imageName") as! String
        //return info[0].valueForKey("userID")
    }
    
    func logoutUser()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "UserInfo")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }

        } catch let error as NSError {
            print("Detele all data error : \(error) \(error.userInfo)")
        }
    }


    
}