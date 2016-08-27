//
//  AlbumCollectionViewController.swift
//  Rio2016
//
//  Created by Helena Leitão on 19/08/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

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
        
        //self.collectionView!.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stickersList.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("stickerCell", forIndexPath: indexPath)
      
<<<<<<< HEAD
        let stickerImageView = UIImageView(frame: CGRectMake(0,0,cell.frame.width,cell.frame.height))
        
//        if stickersList[indexPath.row].valueForKey("photo") as? String != nil {
//            
//            //
//            
//        }
//        
//        else {
//            
//            stickerImageView.image = UIImage(named: "\((stickersList[indexPath.row].valueForKey("cover") as? String)!)")
//            
//            print(stickersList[indexPath.row].valueForKey("cover") as? String)
//            
//        }
        
        let nameLabel = UILabel(frame: CGRectMake(0,0,cell.frame.width,cell.frame.height/2))
=======
        let nameLabel = UILabel(frame: CGRectMake(20,15,80,80))
        nameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        nameLabel.numberOfLines = 3
        nameLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
>>>>>>> da88b82642943779750fb4ccf71226b992a04e2e
        nameLabel.lineBreakMode = .ByWordWrapping
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .Center
        cell.contentView.addSubview(nameLabel)
        
//        let numberLabel = UILabel(frame: CGRectMake(0,cell.frame.height/2,50,40))
//        numberLabel.textColor = UIColor.blackColor()
//        nameLabel.text = "\(indexPath.row + 1)"
//        numberLabel.textAlignment = .Center
//        cell.contentView.addSubview(numberLabel)
        
        let thisSticker = stickersList[indexPath.row]
       
        nameLabel.text = thisSticker.valueForKey("name") as? String
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        cellIndex = indexPath.row
        performSegueWithIdentifier("place", sender: self)
        
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let size = CGSize(width: (self.view.frame.width-2)/3, height: (self.view.frame.width-2)/3)
        
        return size
        
    }

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
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
}