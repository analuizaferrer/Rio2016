//
//  Sticker.swift
//  Rio2016
//
//  Created by Ana Luiza Ferrer on 8/18/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import Foundation

struct Sticker
{
    let name: String?
    let description: String?
    let latitude: String?
    let longitude: String?
    let cover: String?
    let photo: String?
    let date: String?
    
    init(name: String, description: String, latitude: String, longitude: String, cover: String, photo: String, date: String)
    {
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.cover = cover
        self.photo = photo
        self.date = date
    }
}
