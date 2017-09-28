//
//  Image.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/28/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Image {
    
    var nsImage: NSImage?
    var fileURL: URL
    
    init(fileURL: URL) {
        self.fileURL = fileURL
        
        loadImage { (image) in
            self.nsImage = image
        }
        
    }
    
    private func loadImage(completion: @escaping (NSImage?)->Void) {
        
        ImageManager.instance.importImage(from: fileURL) { (image) in
            completion(image)
        }
        
    }
    
}
