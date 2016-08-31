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
import AVFoundation

class StickerViewController: UIViewController, CLLocationManagerDelegate {
    
    //CoreLocation
    var locationManager = CLLocationManager()
    var location = CLLocation()
    
    //CoreData
    var stickerManagedObject: NSManagedObject!
    
    // Labels and buttons
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var locationStatusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var getStickerButton: UIButton!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = stickerManagedObject.valueForKey("name") as? String
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.font = UIFont(name: "Avenir-Black", size: 24)
        nameLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        self.view.addSubview(nameLabel)
        
        getStickerButton.hidden = true
        locationStatusLabel.hidden = true
        
        descriptionText.font = UIFont(name: "Avenir-Roman", size: 16)
        descriptionText.text = stickerManagedObject.valueForKey("stickerDescription") as? String
        self.view.addSubview(descriptionText)
        descriptionText.backgroundColor = UIColor.clearColor()
        descriptionText.editable = false
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func base64Decode (strBase64: String) -> UIImage {
        
        let decodedData: NSData = NSData(base64EncodedString: strBase64, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        
        let decodedImage: UIImage = UIImage(data: decodedData)!
        
        return decodedImage
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.last!
        locationManager.stopUpdatingLocation()
        
        compareLocation()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: NSLocalizedString("ALERT_TITLE", comment: ""), message: NSLocalizedString("ALERT_BODY", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func compareLocation () {
        
        let stickerLat = stickerManagedObject.valueForKey("latitude") as! Double
        let stickerLong = stickerManagedObject.valueForKey("longitude") as! Double
        let stickerLocation = CLLocation(latitude: stickerLat, longitude: stickerLong)
        
        if location.distanceFromLocation(stickerLocation) < 500 {
            
           // locationStatusLabel.text = NSLocalizedString("HERE_LABEL", comment: "")
            locationStatusLabel.hidden = true
            getStickerButton.hidden = false
            
        } else {

            getStickerButton.hidden = true
            locationStatusLabel.text = NSLocalizedString("VISIT", comment: "") + " " + String(stickerManagedObject.valueForKey("name")!) + " " + NSLocalizedString("TO_GET_STICKER", comment: "")
            locationStatusLabel.hidden = false
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if stickerManagedObject.valueForKey("photo") as? String != nil {
            
            stickerImageView.image = base64Decode((stickerManagedObject.valueForKey("photo") as? String)!)
            
        } else {
            
            stickerImageView.image = UIImage(named: (stickerManagedObject.valueForKey("cover") as? String)!)
            
            updateLocation()
            
            locationStatusLabel.lineBreakMode = .ByWordWrapping
            locationStatusLabel.numberOfLines = 0
            self.view.addSubview(locationStatusLabel)
            
            getStickerButton.setTitle(NSLocalizedString("GET_STICKER_BUTTON", comment: ""), forState: UIControlState.Normal)
            getStickerButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            getStickerButton.addTarget(self, action: #selector(StickerViewController.getStickerButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        self.view.addSubview(stickerImageView)
    }
    
    func presentActivityVCForImage(image: UIImage) {
        self.presentViewController(
            UIActivityViewController(activityItems: [image], applicationActivities: nil),
            animated: true,
            completion: nil
        )
    }
    
    func getStickerButtonAction () {
        
        performSegueWithIdentifier("segueToNewSticker", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToNewSticker" {
            
            let nextVC =  segue.destinationViewController as! NewStickerViewController
            
            nextVC.stickerManagedObject = stickerManagedObject
            
        }
        
    }


}
