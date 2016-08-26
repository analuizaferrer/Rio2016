//
//  NewStickerViewController.swift
//  Rio2016
//
//  Created by Ana Luiza Ferrer on 8/25/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import AVFoundation

class NewStickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //CoreData
    var stickerManagedObject: NSManagedObject!
    
    //AVFoundation
    var session: AVCaptureSession!
    var input: AVCaptureDeviceInput!
    var output: AVCaptureStillImageOutput!
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var selectedDevice: String?
    var photo: UIImage?
    
    var confirmationView: UIView!
    
    let photoLibraryButton = UIButton(frame: CGRectMake(-20,600,320,50))
    let cameraButton = UIButton(frame: CGRectMake(170,600,320,50))
    
    //ConfirmationView labels and buttons
    var pictureImageView = UIImageView(frame: CGRectMake(0, 0, 375, 590))
    let confirmButton = UIButton(frame: CGRectMake(170,600,320,50))
    let cancelButton = UIButton(frame: CGRectMake(-20,600,320,50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AVFoundation
        setupSession()

        self.view.backgroundColor = UIColor.cyanColor()
        
        photoLibraryButton.setTitle(NSLocalizedString("PHOTO_LIBRARY_BUTTON", comment: ""), forState: UIControlState.Normal)
        photoLibraryButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        photoLibraryButton.titleLabel?.textAlignment = NSTextAlignment.Left
        photoLibraryButton.addTarget(self, action: #selector(NewStickerViewController.photoLIbraryButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(photoLibraryButton)
        
        cameraButton.setTitle(NSLocalizedString("CAMERA_BUTTON", comment: ""), forState: UIControlState.Normal)
        cameraButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cameraButton.titleLabel?.textAlignment = NSTextAlignment.Left
        cameraButton.addTarget(self, action: #selector(NewStickerViewController.cameraButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(cameraButton)
        
        //ConfirmationView labels and buttons
        confirmationView = UIView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        confirmationView.backgroundColor = UIColor.purpleColor()
        
        confirmationView.addSubview(pictureImageView)
        
        confirmButton.setTitle(NSLocalizedString("CONFIRM_BUTTON", comment: ""), forState: UIControlState.Normal)
        confirmButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        confirmButton.titleLabel?.textAlignment = NSTextAlignment.Left
        confirmButton.addTarget(self, action: #selector(NewStickerViewController.confirmButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        confirmationView.addSubview(confirmButton)
        
        cancelButton.setTitle(NSLocalizedString("CANCEL_BUTTON", comment: ""), forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cancelButton.titleLabel?.textAlignment = NSTextAlignment.Left
        cancelButton.addTarget(self, action: #selector(NewStickerViewController.cancelButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        confirmationView.addSubview(cancelButton)
        
        pictureImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        self.view.layer.addSublayer(previewLayer!)
        
        session.startRunning()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer?.frame = CGRectMake(0, 64, view.frame.width, 500)
    }

    
    func photoLIbraryButtonAction() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        photo = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
        
        self.pictureImageView.image = photo
        
        self.selectedDevice = "photo library"
        self.view.addSubview(self.confirmationView)
        
    }
    
    func cameraButtonAction () {
        
        guard let connection = output.connectionWithMediaType(AVMediaTypeVideo) else { return }
        connection.videoOrientation = .Portrait
        
        output.captureStillImageAsynchronouslyFromConnection(connection) { (sampleBuffer, error) in
            guard sampleBuffer != nil && error == nil else { return }
            
            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
            guard let image = UIImage(data: imageData) else { return }
            
            self.pictureImageView.image = image
            self.photo = image
            
            self.selectedDevice = "camera"
            self.view.addSubview(self.confirmationView)
            
        }
    }
    
    func confirmButtonAction () {
        
        if self.selectedDevice == "camera" {
           
            UIImageWriteToSavedPhotosAlbum(photo!, nil, nil, nil)
        
        }
        
        base64Encode(photo!)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func base64Encode (image: UIImage) {
        
        let imageData: NSData = UIImagePNGRepresentation(image)!
        let strBase64: String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        updateStickerObject(strBase64)
        
    }
    
    func updateStickerObject(image: String) {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Sticker")
        fetchRequest.predicate = NSPredicate(format: "name = %@", stickerManagedObject.valueForKey("name") as! String)
        
        do {
            
            if let fetchResults = try appDel.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                if fetchResults.count != 0{
                    
                    let managedObject = fetchResults[0]
                    managedObject.setValue(image, forKey: "photo")
                    
                    do {
                        try context.save()
                    }
                        
                    catch let error as NSError  {
                        
                        print("Could not save \(error), \(error.userInfo)")
                        
                    }
    
                }
            }
            
        }
            
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func cancelButtonAction () {
        
        self.confirmationView.removeFromSuperview()
        
    }

}
