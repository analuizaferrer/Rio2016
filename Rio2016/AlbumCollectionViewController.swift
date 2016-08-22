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
        
        self.collectionView!.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stickersList.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("stickerCell", forIndexPath: indexPath)
      
        let nameLabel = UILabel(frame: CGRectMake(18,0,320,50))
        cell.contentView.addSubview(nameLabel)
        
        let thisSticker = stickersList[indexPath.row]
       
        nameLabel.text = thisSticker.valueForKey("name") as? String
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("place", sender: self)
        
    }
}