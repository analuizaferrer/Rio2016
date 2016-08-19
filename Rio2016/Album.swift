//
//  Album.swift
//  Rio2016
//
//  Created by Ana Luiza Ferrer on 8/18/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

class Album: UITableViewController {
    
    var stickersList = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "stickerCell")
        
        let nameLabel = UILabel(frame: CGRectMake(18,0,320,50))
        cell.contentView.addSubview(nameLabel)
        
        let thisSticker = stickersList[indexPath.row]
        
        nameLabel.text = thisSticker.valueForKey("name") as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return stickersList.count
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
        
        self.tableView.reloadData()
    }


}
