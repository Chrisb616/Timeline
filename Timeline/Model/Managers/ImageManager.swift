//
//  ImageManager.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/11/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class ImageManager {
    
    static let instance = ImageManager()
    private init() {
        importQueue.qualityOfService = .background
        exportQueue.qualityOfService = .background
    }
    
    var importQueue = OperationQueue()
    var exportQueue = OperationQueue()
    
    func importSingleImage(withFileURL url: URL, completion: @escaping (NSImage) -> Void) {
        Debugger.log(string: "Importing single image from \(url), adding to import thread", logType: .process, logLevel: .verbose)
        
        importQueue.addOperation {
            
            guard let image = NSImage(contentsOf: url) else {
                Debugger.log(string: "Could not import image from \(url)", logType: .failure, logLevel: .minimal)
                return
            }
            
            Debugger.log(string: "Imported image from \(url)", logType: .success, logLevel: .verbose)
            completion(image)
        }
    }
    
    func exportSingleImage(toFileURL url: URL, image: NSImage, name: String) {
        
        exportQueue.addOperation {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: [:])
            } catch {
                Debugger.log(string: "Could not create directory at \(url)", logType: .failure, logLevel: .minimal)
                Debugger.log(error: error)
            }
            
            let fileURL = url.appendingPathComponent(name).appendingPathExtension("jpg")
            
            guard let bits = image.representations.first as? NSBitmapImageRep else {
                Debugger.log(string: "Could not create bits out of image", logType: .failure, logLevel: .minimal)
                return
            }
            let imageData = bits.representation(using: .jpeg, properties: [:])
            
            do {
                try imageData?.write(to: fileURL)
            } catch {
                Debugger.log(string: "Could not write image data to \(fileURL)", logType: .failure, logLevel: .minimal)
                Debugger.log(error: error)
            }
        }
        
    }
    
}


