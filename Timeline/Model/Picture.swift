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
    
    var savePath: URL { return UserPreferences.instance.directoryHome.appendingPathComponent("Pictures").appendingPathComponent(uniqueID).appendingPathExtension("jpg") }
    
    func refreshImage() {
        ImageManager.instance.importSingleImage(withFileURL: savePath) { (image) in
            self.image = image
            NotificationManager.instance.postPictureUpdateNotification()
        }
    }
    
    init(uniqueID: UniqueID, title: String, date: Date, image: NSImage) {
        self.uniqueID = uniqueID
        self.title = title
        self.image = image
        self.date = date
    }
    
}
