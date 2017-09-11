//
//  Picture.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/8/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Picture: HasUniqueID {
    
    var image: NSImage
    var title: String
    var uniqueID: UniqueID
    
    var date: Date
    
    init(uniqueID: UniqueID, title: String, date: Date, image: NSImage) {
        self.uniqueID = uniqueID
        self.title = title
        self.image = image
        self.date = date
    }
    
}
