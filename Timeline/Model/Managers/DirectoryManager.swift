//
//  DirectoryManager.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/11/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class DirectoryManager {
    
    static let instance = DirectoryManager()
    private init() {}
    
    //MARK: - Utilities
    private var fileManager = FileManager.default
    
    var directoryHome: URL { return UserPreferences.instance.directoryHome }
    
    var timelineDirectory: URL { return directoryHome.appendingPathComponent("Timeline") }
    
    var infoDirectory: URL { return directoryHome.appendingPathComponent("Info") }
    var eventInfoDirectory: URL { return infoDirectory.appendingPathComponent("EventInfo").appendingPathExtension(infoFileExtension) }
    var pictureInfoDirectory: URL { return infoDirectory.appendingPathComponent("PictureInfo").appendingPathExtension(infoFileExtension) }
    
    var picturesDirectory: URL { return directoryHome.appendingPathComponent("Pictures") }
    
    var imageFileExtension: String { return "jpg" }
    var infoFileExtension: String { return "json" }
    
    func imageFileURL(forPicture picture: Picture) -> URL {
        return picturesDirectory.appendingPathComponent(picture.uniqueID).appendingPathExtension(imageFileExtension)
    }
    
    func imageFileURL(forUniqueID uniqueID: UniqueID) -> URL {
        return picturesDirectory.appendingPathComponent(uniqueID).appendingPathExtension(imageFileExtension)
    }
    
    func setUpDirectory() {
        Debugger.log(string: "Beginning Directory Set Up", logType: .process, logLevel: .verbose)
        
        do {
            try fileManager.createDirectory(at: directoryHome, withIntermediateDirectories: true, attributes: nil)
        } catch {
            Debugger.log(string: "Failed to create directory at directory home.", logType: .failure, logLevel: .minimal)
        }
        
        do {
            try fileManager.createDirectory(at: infoDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            Debugger.log(string: "Failed to create directory at info directory.", logType: .failure, logLevel: .minimal)
        }
        
        do {
            try fileManager.createDirectory(at: picturesDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            Debugger.log(string: "Failed to create directory at pictures directory .", logType: .failure, logLevel: .minimal)
        }
        
        Debugger.log(string: "Finishing Directory Set Up", logType: .process, logLevel: .verbose)
    }
    
}
