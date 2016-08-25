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

class StickerViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pictureView: UIView!
    var confirmationView: UIView!
    
    //CoreLocation
    var locationManager = CLLocationManager()
    var location = CLLocation()
    
    //AVFoundation
    var session: AVCaptureSession!
    var input: AVCaptureDeviceInput!
    var output: AVCaptureStillImageOutput!
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    //CoreData
    var stickerManagedObject: NSManagedObject!
    
    //View labels and buttons
    let nameLabel = UILabel(frame: CGRectMake(20,100,320,50))
    let locationLabel = UILabel(frame: CGRectMake(20,200,320,50))
    var getStickerButton = UIButton(frame: CGRectMake(100,500,320,50))
    var descriptionText = UITextView(frame: CGRectMake(100,500,320,50))
    
    //PictureView labels and buttons
    let photoLibraryButton = UIButton(frame: CGRectMake(-20,600,320,50))
    let cameraButton = UIButton(frame: CGRectMake(170,600,320,50))
    var pictureImageView = UIImageView(frame: CGRectMake(0, 0, 375, 590))
    
    //ConfirmationView labels and buttons
    let confirmButton = UIButton(frame: CGRectMake(170,600,320,50))
    let cancelButton = UIButton(frame: CGRectMake(-20,600,320,50))
    
    var selectedDevice: String?
    
    var photo: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLocation()
        
    //View labels and buttons
        
        nameLabel.text = stickerManagedObject.valueForKey("name") as? String
        self.view.addSubview(nameLabel)
        
        descriptionText.text = stickerManagedObject.valueForKey("stickerDescription") as? String
        self.view.addSubview(descriptionText)
        
        getStickerButton.setTitle("Get sticker!", forState: UIControlState.Normal)
        getStickerButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        getStickerButton.addTarget(self, action: #selector(StickerViewController.pictureCaptureView), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    //PictureView labels and buttons
        pictureView = UIView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        pictureView.backgroundColor = UIColor.cyanColor()
        
        photoLibraryButton.setTitle("Photo library", forState: UIControlState.Normal)
        photoLibraryButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        photoLibraryButton.titleLabel?.textAlignment = NSTextAlignment.Left
        photoLibraryButton.addTarget(self, action: #selector(StickerViewController.photoLIbraryButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        pictureView.addSubview(photoLibraryButton)
        
        cameraButton.setTitle("Camera", forState: UIControlState.Normal)
        cameraButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cameraButton.titleLabel?.textAlignment = NSTextAlignment.Left
        cameraButton.addTarget(self, action: #selector(StickerViewController.cameraButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        pictureView.addSubview(cameraButton)
        
    //ConfirmationView labels and buttons
        confirmationView = UIView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        confirmationView.backgroundColor = UIColor.purpleColor()
        
        confirmButton.setTitle("Confirm", forState: UIControlState.Normal)
        confirmButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        confirmButton.titleLabel?.textAlignment = NSTextAlignment.Left
        confirmButton.addTarget(self, action: #selector(StickerViewController.confirmButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        confirmationView.addSubview(confirmButton)
        
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cancelButton.titleLabel?.textAlignment = NSTextAlignment.Left
        cancelButton.addTarget(self, action: #selector(StickerViewController.cancelButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        confirmationView.addSubview(cancelButton)
        
        confirmationView.addSubview(pictureImageView)
        
    //AVFoundation
        
        setupSession()
        
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
        
        compareLocation()
    }
    
    func compareLocation () {
        
        let stickerLat = stickerManagedObject.valueForKey("latitude") as! Double
        let stickerLong = stickerManagedObject.valueForKey("longitude") as! Double
        let stickerLocation = CLLocation(latitude: stickerLat, longitude: stickerLong)
        
        if location.distanceFromLocation(stickerLocation) < 500 {
            
            locationLabel.text = "You're here!"
            self.view.addSubview(getStickerButton)

        }
        
        else {
            
            locationLabel.text = "Visit \(stickerManagedObject.valueForKey("name") as! String) to get this sticker!"
            
        }
        
        self.view.addSubview(locationLabel)
        
    }
    
    func cameraButtonAction () {
       
        guard let connection = output.connectionWithMediaType(AVMediaTypeVideo) else { return }
        connection.videoOrientation = .Portrait
        
        output.captureStillImageAsynchronouslyFromConnection(connection) { (sampleBuffer, error) in
            guard sampleBuffer != nil && error == nil else { return }
            
            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
            guard let image = UIImage(data: imageData) else { return }
            
            self.pictureImageView.image = image
//            self.confirmationView.addSubview(self.pictureImageView)
            
            self.photo = image
            
            self.view.addSubview(self.confirmationView)
            
            self.selectedDevice = "camera"
        }
    }

    func photoLIbraryButtonAction() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
        
        self.view.addSubview(confirmationView)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        photo = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
        
        self.pictureImageView.image = photo
        self.pictureView.addSubview(self.pictureImageView)
        
        self.selectedDevice = "photo library"
        
    }
    
    func setupSession() {
       
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetPhoto
        
        let camera = AVCaptureDevice
            .defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do { input = try AVCaptureDeviceInput(device: camera) } catch { return }
        
        output = AVCaptureStillImageOutput()
        output.outputSettings = [ AVVideoCodecKey: AVVideoCodecJPEG ]
        
        guard session.canAddInput(input)
            && session.canAddOutput(output) else { return }
        
        session.addInput(input)
        session.addOutput(output)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
        previewLayer!.connection?.videoOrientation = .Portrait
        
        pictureView.layer.addSublayer(previewLayer!)
        
        session.startRunning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer?.frame = CGRectMake(0, 64, view.frame.width, 455)
    }
    
    func presentActivityVCForImage(image: UIImage) {
        self.presentViewController(
            UIActivityViewController(activityItems: [image], applicationActivities: nil),
            animated: true,
            completion: nil
        )
    }
    
    func pictureCaptureView () {
        
        self.view.addSubview(pictureView)
        
    }
    
    func confirmButtonAction () {
        
        if self.selectedDevice == "camera" {
            UIImageWriteToSavedPhotosAlbum(photo!, nil, nil, nil)
        }
        
//        self.presentViewController(AlbumCollectionViewController(), animated: true, completion: nil)
        
    }
    
    func cancelButtonAction () {
        
        self.view = pictureView
        
    }

}
