//
//  ImageManager.swift
//  Timeline
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class ImageManager {
    
    static let instance = ImageManager()
    private init() {}
    
    func importImage(from url: URL, completion: @escaping (NSImage?) -> Void) {
        let image = NSImage(contentsOf: url)
        completion(image)
    }
    
}
