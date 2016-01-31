//
//  registerViewController.swift
//  Apple Challenge
//
//  Created by minh duong on 1/30/16.
//  Copyright © 2016 minh duong. All rights reserved.
//

import UIKit

class registerViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var repeatPassword: UITextField!
    
    //function to display an alert message
    func displayAlert(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            // Fallback on earlier versions
        }
        
    }

    
    @IBAction func register(sender: AnyObject) {
        
        if username.text == "" || password.text == "" || repeatPassword.text == "" {
            
            displayAlert("Invalid form", message: "please enter the appropriate information")
            
        } else {
            
            var errorMessage = "Try again"
            
            if password.text! == repeatPassword.text! {
                let parameters = [
                    "username":username.text!,
                    "password":password.text!
                ] as Dictionary<String,String>
                
                let url = NSURL(string: "http://hh.nickrung.me:3000/api")
                
                let session = NSURLSession.sharedSession()
                
                let requrest = NSMutableURLRequest(URL: url!)
                
                requrest.HTTPMethod = "POST"
                
                var err:NSError?
                do {
                     requrest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions())
                
                }catch {
                
                }
                
                //create dataTask using the session object to send data to the server
                let task = session.dataTaskWithRequest(requrest, completionHandler: { (data, response, error) -> Void in
                    print("Response: \(response)")
                    
                    let dataSTR = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Body: \(dataSTR)")
                    
                    do{
                        //did the JSONOBJECTWithData return error?
                        if let json = try NSJSONSerialization.JSONObjectWithData(data! , options: .MutableLeaves) as? NSDictionary {
                            
                            // The JSONObjectWithData constructor didn't return an error. But, we should still
                            // check and make sure that json has a value using optional binding.
                        
                                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                            let success = json["success"] as? Int
                            print("Succes: \(success)")
                            
                            //successful register
                            //move to ready login view
                            self.performSegueWithIdentifier("finishRegister", sender: self)
                            
                            
                        } else {
                            
                            print("error with json")
                            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                            print("error could not parse Json: \(jsonStr)")
                            
                        }
                        
                    } catch {
                        
                    }
                })
                
                task.resume()
            }
            
            
            
        }
        
        
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
