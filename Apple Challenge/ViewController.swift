//
//  ViewController.swift
//  Apple Challenge
//
//  Created by minh duong on 1/28/16.
//  Copyright © 2016 minh duong. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var receiveTopic = ""
    var receiveDetail = ""
    var receiveTime:Int = 0
    
    var longitude:CLLocationDegrees = 0
    var latitude:CLLocationDegrees = 0
    
    
    let pin = MKPointAnnotation()
    //let currentPin = MKPointAnnotation()
    var timer = NSTimer()
    var checkTime  = 0
    var timeInterval  = 5
    //set the funciton to the variable. it will trigger the function whenever you set the value to
    var updateLocationActive:Bool! {
    
        didSet{
        
            if updateLocationActive == true {
                
                manager.startUpdatingLocation()
                
            } else {
                
                manager.stopUpdatingLocation()
                
            }
        
        }
    
    }
    
    @IBAction func addForm(sender: AnyObject) {
        
        //self.performSegueWithIdentifier("form", sender: self )
        // if timer is working
        if timer.valid == true {
            
            // create a new form. We need to stop the timer
            timer.invalidate()
            
            
        }
        
    }
    
    
    @IBAction func stopMap(sender: AnyObject) {
        
        timer.invalidate()
        
    }
    
    
    @IBAction func pauseTimer(sender: AnyObject) {
        
        manager.stopUpdatingLocation()
        
    }
    
    
    @IBAction func resumeUpdateLocation(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(timeInterval), target: self, selector: Selector("updateLocation"), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func logOUt(sender: AnyObject) {
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        self.performSegueWithIdentifier("logout", sender: self)
        
    }
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locationInformation: UILabel!
    
    var manager:CLLocationManager!
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateLocationActive = false
    }

    
    //pass data between sequence
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "form" {
            
            if let destination = segue.destinationViewController as? formViewController {
                
                timer.invalidate()
                
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up location manager. 
        // ask if user allows the map to identify the current location
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        
        //set up the map display
        mapView.delegate = self
        mapView.mapType = MKMapType.Satellite
        //mapView.showsUserLocation = true
        
        
        if receiveTime != 0 {
            updateLocationActive = true
            
            timer = NSTimer.scheduledTimerWithTimeInterval(Double(timeInterval), target: self, selector: Selector("updateLocation"), userInfo: nil, repeats: true)
            
                
            
            
        } else {
            print("not start timer yet")
            
        }
        
    }
    
        
    func updateLocation() {
        if checkTime < receiveTime {
            checkTime += timeInterval
            updateLocationActive = true
            print("total time : \(receiveTime)")
        } else {
            //stop the timer if we pass the limit amount of time
            print("stop timer")
            updateLocationActive = false
            timer.invalidate()
            print("check time: \(checkTime)")
        }
        

        
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        //save the latitude and longitude globally
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        //display the map
        //
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.pin.coordinate = center
        
        let spanX = 0.005
        
        let spanY = 0.005
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: spanX, longitudeDelta: spanY))
        
        self.mapView.setRegion(region, animated: true)
        
        //display the address by convert location into readable address
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            if error != nil {
                
                print("fail with error "+(error?.localizedDescription)!)
                return
            }
            
            if placemarks?.count > 0 {
                
                let p = placemarks![0]
                //short cut for if statement
                let country = p.country ?? ""
                let locality = p.locality ?? ""
                let administrative = p.administrativeArea ?? ""
                let postal = p.postalCode ?? ""
                let subThrough = p.subThoroughfare ?? ""
                let thoroughfare = p.thoroughfare ?? ""
                
                self.locationInformation.text = "\(subThrough), \(thoroughfare), \(administrative), \(postal), \(locality), \(country)"
                //print(self.receiveTime)
                self.updateLocationActive = false
                
                
                self.pin.title = "\(self.receiveTopic)"
                self.pin.subtitle = "now - "
                self.mapView.addAnnotation(self.pin)
                self.mapView.selectAnnotation(self.pin, animated: true)
                
                
                
            }
            
        }
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

