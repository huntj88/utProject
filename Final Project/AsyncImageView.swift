//
//  AsyncImageView.swift
//  Final Project
//
//  Created by Hunt, James V on 11/30/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

let imageCache = NSCache()

class AsyncImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.objectForKey(urlString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString)
            })
            
        }).resume()
    }
    
}
