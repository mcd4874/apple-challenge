//
//  readyLoginController.swift
//  Apple Challenge
//
//  Created by minh duong on 1/30/16.
//  Copyright © 2016 minh duong. All rights reserved.
//

import UIKit

class readyLoginController: UIViewController {

    
    @IBAction func moveToLogin(sender: AnyObject) {
        
        performSegueWithIdentifier("login", sender: self)
        
    }
    
    
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
