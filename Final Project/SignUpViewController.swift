//
//  SignUpViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 11/21/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var CellPhone: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var AptNumber: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var ZipCode: UITextField!
    @IBOutlet weak var State: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
