//
//  ItemDescriptionViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/21/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class ItemDescriptionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var userImagePhoto = UIImage()
    
    var myItem:item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemName.text = myItem?.itemName
        self.userImage.image = userImagePhoto
        self.username.text = myItem!.name
        self.price.text = "$"+String((myItem?.price)!)
        self.itemDescription.text = myItem?.description
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        // Do any additional setup after loading the view.
        
        /*if let url = NSURL(string: "http://138.68.41.247:2996/items/image/da862d74-4363-44e9-baaf-004ebd2e575a.jpg") {
            if let data = NSData(contentsOfURL: url) {
                userImage.image = UIImage(data: data)
            }        
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let imageName = myItem!.imageNames.characters.split{$0 == ","}.map(String.init)
        return imageName.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:ItemCollectionViewCell = myCollectionView.dequeueReusableCellWithReuseIdentifier("itemDescriptionImageCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        
        let imageName = myItem!.imageNames.characters.split{$0 == ","}.map(String.init)
        cell.itemImage.loadImageUsingUrlString("http://138.68.41.247:2996/items/image/"+imageName[indexPath.row])
        
        return cell
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
