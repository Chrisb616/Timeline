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
            OperationQueue.main.addOperation {
                NotificationManager.instance.postPictureUpdateNotification()
            }
        }
    }
    
    func image(sizeTo size: CGSize) -> NSImage {
        
        let heightFit = size.height / image.size.height
        let widthFit = size.width / image.size.width
        
        var newSize = CGSize()
        
        if heightFit > widthFit {
            newSize.width = size.width
            newSize.height = image.size.height * widthFit
        } else {
            newSize.width = image.size.width * heightFit
            newSize.height = size.height
        }
        
        image.size = newSize
        return image
    }
    
    init(uniqueID: UniqueID, title: String, date: Date, image: NSImage) {
        self.uniqueID = uniqueID
        self.title = title
        self.image = image
        self.date = date
    }
    
}
