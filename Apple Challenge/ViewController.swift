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

var longitude:CLLocationDegrees = 0
var latitude:CLLocationDegrees = 0

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var timer = NSTimer()
    
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
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var locationInformation: UILabel!
    
    var manager:CLLocationManager!
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateLocationActive = true
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
        mapView.showsUserLocation = true
        
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("updateLocation"), userInfo: nil, repeats: true)
        
    }
    
    func updateLocation() {
        
        updateLocationActive = true
        
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var userLocation: CLLocation = locations[0]
        
        //save the latitude and longitude globally
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        //display the map
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        var spanX = 0.005
        
        var spanY = 0.005
        
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
                
                self.updateLocationActive = false
            }
            
        }
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

