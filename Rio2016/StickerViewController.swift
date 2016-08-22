//
//  StickerViewController.swift
//  Rio2016
//
//  Created by Ana Luiza Ferrer on 8/21/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import CoreData

class StickerViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var location = CLLocation()
    
    var stickerManagedObject: NSManagedObject!
    
    let nameLabel = UILabel(frame: CGRectMake(20,100,320,50))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLocation()
        
        nameLabel.text = stickerManagedObject.valueForKey("name") as? String
        self.view.addSubview(nameLabel)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func updateLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()
    }
    
    func checkCoreLocationPermission () {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            
            locationManager.startUpdatingLocation()
            
        } else if CLLocationManager.authorizationStatus() == .NotDetermined {
            
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
        } else {
            
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Hold Up...", message: "Before you continue, Rio 2016 wants access to your location. Please turn on Location Services in your device settings.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.last!
        locationManager.stopUpdatingLocation()
    }
    

}
