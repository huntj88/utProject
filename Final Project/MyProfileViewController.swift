//
//  MyProfileViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/29/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var items = [item]()
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var major: UILabel!

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var myListings: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.image = UIImage(named: "TempProfilePic")

        // Do any additional setup after loading the view.
        myListings.dataSource = self
        myListings.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : ItemCollectionViewCell = myListings.dequeueReusableCellWithReuseIdentifier("myItems", forIndexPath: indexPath) as! ItemCollectionViewCell
        //cell.itemName.text = items[indexPath.row].itemName
        cell.itemImage.image = UIImage(named: "TempItemPic")!
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        
        return CGSizeMake(width, width)
    }
}
