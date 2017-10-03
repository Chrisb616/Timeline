//
//  Image.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/28/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Image {
    
    //MARk: - Properties
    
    private var nsImage: NSImage?
    var imageURL: URL?

    var valueOrDefault: NSImage {
        return nsImage ?? NSImage(named: NSImage.Name("EventIcon")) ?? NSImage()
    }
    
    var valueOrNull: NSImage? {
        return nsImage
    }
    
    //MARK: - Initializers
    
    static var blank: Image {
        return Image()
    }
    
    private init() {
        
    }
    
    init(image: NSImage, fromURL url: URL) {
        self.nsImage = image
        self.imageURL = url
    }
    
    init(imageURL: URL) {
        self.imageURL = imageURL
        
        loadImage { (image) in
            self.nsImage = image
        }
        
    }
    
    //MARK: - Methods

    func updateImage(withURL url: URL) {
        self.imageURL = url
        loadImage { (image) in
            self.nsImage = image
        }
    }
    
    private func loadImage(completion: @escaping (NSImage?)->Void) {
        
        guard let imageURL = imageURL else { Debugger.log(string: "Cannot retrieve image because fileURL is null", logType: .warning, logLevel: .full); return}
        
        ImageManager.instance.importImage(from: imageURL) { (image) in
            completion(image)
        }
        
    }
    
}
