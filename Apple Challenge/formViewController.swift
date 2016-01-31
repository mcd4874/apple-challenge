//
//  formViewController.swift
//  Apple Challenge
//
//  Created by minh duong on 1/30/16.
//  Copyright © 2016 minh duong. All rights reserved.
//

import UIKit

class formViewController: UIViewController {

    @IBOutlet weak var topic: UITextField!
    
    @IBOutlet weak var detail: UITextField!
    
    @IBOutlet weak var hours: UITextField!
    
    @IBOutlet weak var minutes: UITextField!
    
    @IBOutlet weak var second: UITextField!
    
    var totalSeconds:Int = 0
    
    var longitude = 0
    
    var latitude = 0
    
    
    //pass data between sequence
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "formToMap" {
            
            if let destination = segue.destinationViewController as? ViewController {
                
                if topic.text == "" || detail.text == "" || (hours.text == "" && minutes.text == "" && second.text == "" ) {
                
                    print("fail to submit form")
                
                } else {
                
                    var hourToSecond = (Int(hours.text!) ?? 0) * 3600
                    
                    var minuteToSecond = (Int(minutes.text!) ?? 0) * 60
                    
                    var seconds = Int(second.text!) ?? 0
                    
                    totalSeconds = hourToSecond + minuteToSecond + seconds
                    
                    destination.receiveDetail = detail.text!
                    
                    destination.receiveTime = totalSeconds
                    
                    destination.receiveTopic = topic.text!
                    
                    //destination.updateLocationActive = true
                
                }
                
                
                
                
            }
            
        }
        
    }
    
    //submit the form
    @IBAction func submit(sender: AnyObject) {
        

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
