//
//  ViewController.swift
//  Location Aware
//
//  Created by Abdallah Eid on 10/25/17.
//  Copyright © 2017 TripleApps. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var nearestAddressLabel: UILabel!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
            
        longitudeLabel.text = String(location.coordinate.longitude)
        
        latitudeLabel.text = String(location.coordinate.latitude)
        
        courseLabel.text = String(location.course)
        
        speedLabel.text = String(location.speed)
        
        altitudeLabel.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks ,error) in
            
            if (error != nil){
                
                print (error)
                
            }else{
                
                if let placemark = placemarks?.first {
                    
                    var address = ""
                    
                    if placemark.subThroughfare != nil {
                        
                        address += placemark.subThroughfare + " "
                        
                    }
                    
                    if placemark.throughfare != nil {
                        
                        address += placemark.throughfare + "\n"
                        
                    }
                    
                    if placemark.subLocality != nil {
                        
                        address += placemark.subLocality + "\n"
                        
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea + "\n"
                        
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode + "\n"
                        
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country + "\n"
                        
                    }
                    
                    self.nearestAddressLabel.text = address
                }
                
            }
        
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

