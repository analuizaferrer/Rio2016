//
//  Album.swift
//  Rio2016
//
//  Created by Ana Luiza Ferrer on 8/18/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit

class Album: UITableViewController {
    
    let christRedeemer = Sticker(name: "Christ Redeemer", description: "", latitude: "", longitude: "", cover: "", photo: "", date: "")
    let sugarLoaf = Sticker(name: "Sugar Loaf", description: "", latitude: "", longitude: "", cover: "", photo: "", date: "")
    let copacabanaBeach = Sticker(name: "Copacabana Beach", description: "", latitude: "", longitude: "", cover: "", photo: "", date: "")
    
    var stickers: [Sticker] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stickers += [christRedeemer,sugarLoaf,copacabanaBeach]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "stickerCell")
        
        var nameLabel = UILabel(frame: CGRectMake(18,0,320,50))
        cell.contentView.addSubview(nameLabel)
        
        let thisSticker = stickers[indexPath.row]
        
        nameLabel.text = thisSticker.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return stickers.count
    }

}
