//
//  AlbumCollectionViewController.swift
//  Rio2016
//
//  Created by Helena Leitão on 19/08/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "stickerCell"

class AlbumCollectionViewController: UICollectionViewController {

    var stickersList = [NSManagedObject]()
    
    var cellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchStickers()
        
    }
    
    func fetchStickers() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestSticker = NSFetchRequest(entityName: "Sticker")
        
        do {
            
            let resultsSticker = try managedContext.executeFetchRequest(fetchRequestSticker)
            stickersList = resultsSticker as! [NSManagedObject]
            
        }
        
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
       // self.collectionView!.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stickersList.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("stickerCell", forIndexPath: indexPath)
        
        
        let stickerImageView = UIImageView(frame: CGRectMake(0,0,cell.frame.width,cell.frame.height))
        
        
        if stickersList[indexPath.row].valueForKey("photo") as? String != nil {
            
            stickerImageView.image = base64Decode((stickersList[indexPath.row].valueForKey("photo") as? String)!)
            
        }
        
        else {
            
            let coverImage = UIImage(named: "\((stickersList[indexPath.row].valueForKey("cover") as? String)!)")
            stickerImageView.image = coverImage
            
        }
        cell.backgroundView = stickerImageView

        
        let numberLabel = UILabel(frame: CGRectMake(0,0,cell.frame.width,cell.frame.height/2))
        numberLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
        numberLabel.textAlignment = .Center
        numberLabel.clearsContextBeforeDrawing = true
        numberLabel.text = "\(indexPath.row + 1)"
        cell.contentView.addSubview(numberLabel)
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        cellIndex = indexPath.row
        performSegueWithIdentifier("place", sender: self)
        
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let size = CGSize(width: (self.view.frame.width/3)-2, height: (self.view.frame.width/3)-2)
        
        return size
        
    }

    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "place" {
           
            let nextVC =  segue.destinationViewController as! StickerViewController
            
            nextVC.stickerManagedObject = stickersList[cellIndex]

        }
        
    }
    
    func base64Decode (strBase64: String) -> UIImage {
        
        let decodedData: NSData = NSData(base64EncodedString: strBase64, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        
        let decodedImage: UIImage = UIImage(data: decodedData)!
        
        return decodedImage
    }
}

extension UIImage{
    
    func alpha(value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        
        let ctx = UIGraphicsGetCurrentContext();
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -area.size.height);
        CGContextSetBlendMode(ctx, CGBlendMode.Multiply);
        CGContextSetAlpha(ctx, value);
        CGContextDrawImage(ctx, area, self.CGImage);
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
}