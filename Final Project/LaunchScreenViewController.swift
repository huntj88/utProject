//
//  LaunchScreenViewController.swift
//  Final Project
//
//  Created by Choi, Jin W on 12/4/16.
//  Copyright © 2016 MonkeyBrain. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController , HolderViewDelegate{

    var holderView = HolderView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 100.0
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
                                  y: view.bounds.height / 2 - boxSize / 2,
                                  width: boxSize,
                                  height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        view.addSubview(holderView)
        
        holderView.expandView()
        //holderView.drawAnimatedTriangle()
        //This calls addOval to kickstart the animation after it has been added to the view controller’s view.
    }
    
    func animateLabel() {
        // 1
        //holderView.removeFromSuperview()
        view.backgroundColor = Color.blue
        
        // 2
        var label: UILabel = UILabel(frame: view.frame)
        label.textColor = Color.white
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 50.0)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Monkeys R' us"
        label.transform = CGAffineTransformScale(label.transform, 0.001, 0.001)
        view.addSubview(label)
        
        // 3
        UIView.animateWithDuration(2.0, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.01, options: UIViewAnimationOptions.CurveEaseInOut,
                                   animations: ({
                                    label.transform = CGAffineTransformScale(label.transform, 1000.0, 1000.0)
                                   }), completion: { finished in
                                    self.performSegueWithIdentifier("launchIt", sender: nil)
        })
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if segue.identifier == "launchIt" {
            print("Launch Screen")
            if let _: ViewController = segue.destinationViewController as? ViewController{
                print("correct VC, First screen")
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
