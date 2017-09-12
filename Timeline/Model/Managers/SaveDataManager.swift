//
//  SaveDataManager.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

//import Foundation
import Cocoa

class SaveDataManager {
    
    private init() {}
    static let instance = SaveDataManager()
    
    //MARK: - Utilities
    private var userPrefs = UserPreferences.instance
    private var imageManager = ImageManager.instance
    private var dataStore = DataStore.instance
    private var directoryManager = DirectoryManager.instance
    private var fileManager = FileManager.default
    
    //MARK: - Save Paths
    
    private var eventStartKey = "start"
    private var eventEndKey = "end"
    private var eventNameKey = "name"
    private var eventNarrativeKey = "narrative"
    private var eventPicturesKey = "pictures"
    
    private var pictureTitleKey = "title"
    private var pictureDateKey = "date"
    
    private func write(data: Data, toURL url: URL) {
        do {
            try data.write(to: url)
        } catch {
            Debugger.log(string: "Could not save data to \(url)", logType: .failure, logLevel: .minimal)
            Debugger.log(error: error)
        }
    }
    
    private func read(fromURL url: URL) -> [String:Any] {
        do {
            let data = try Data(contentsOf: url, options: [])
            return (try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]) ?? [:]
        } catch {
            Debugger.log(string: "Could not read data from \(url)", logType: .failure, logLevel: .minimal)
            Debugger.log(error: error)
            return [:]
        }
    }
    
    private func deleteFile(atURL url: URL) {
        do {
            try fileManager.removeItem(at: url)
        } catch {
            Debugger.log(string: "Could not delete file at \(url)", logType: .failure, logLevel: .minimal)
        }
    }
    
    //MARK: - General Methods
    
    func loadAllInfo() {
        Debugger.log(string: "Loading all info", logType: .process, logLevel: .full)
        loadEventInfo()
        loadPictureInfo()
    }
    
    func saveAllInfo() {
        Debugger.log(string: "Saving all info", logType: .process, logLevel: .full)
        saveEventInfo()
        savePictureInfo()
    }
    
    //MARK: - Events
    
    func saveEventInfo() {
        let events = dataStore.events
        
        Debugger.log(string: "Saving Event Info for \(events.count) events", logType: .process, logLevel: .verbose)
        
        var eventDictionary = [String:Any]()
        
        for event in events {
            let start = event.dateRange.start.toSaveString
            let end = event.dateRange.end.toSaveString
            let name = event.name
            let uniqueID = event.uniqueID
            let narrative = event.narrative
            let pictures = Array(event.pictures.keys)
            
            let infoDictionary: [String:Any] = [
                eventStartKey: start,
                eventEndKey: end,
                eventNameKey: name,
                eventNarrativeKey: narrative,
                eventPicturesKey: pictures
            ]
            
            eventDictionary.updateValue(infoDictionary, forKey: uniqueID)
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: eventDictionary, options: [])
            write(data: jsonData, toURL: directoryManager.eventInfoDirectory)
            Debugger.log(string: "Saved Event Info for \(eventDictionary.count) events. ", logType: .success, logLevel: .full)
        } catch {
            Debugger.log(string: "Could not serialize data for events", logType: .failure, logLevel: .minimal)
            Debugger.log(error: error)
        }
    }
    
    func loadEventInfo() {
        let dictionary = read(fromURL: directoryManager.eventInfoDirectory)
        var successCount = 0
        Debugger.log(string: "Loading event info for \(dictionary.count) events", logType: .process, logLevel: .verbose)
        
        for (uniqueID, genericEvent) in dictionary {
            guard let eventInfo = genericEvent as? [String:Any] else {
                Debugger.log(string: "Could not convert generic event info into dictionary", logType: .failure, logLevel: .minimal)
                continue
            }
            guard let startString = eventInfo[eventStartKey] as? String else {
                Debugger.log(string: "Could not extract start date string from event info", logType: .failure, logLevel: .minimal)
                continue
            }
            guard let endString = eventInfo[eventEndKey] as? String else {
                Debugger.log(string: "Could not extract end date string from event info", logType: .failure, logLevel: .minimal)
                continue
            }
            guard let name = eventInfo[eventNameKey] as? String else {
                Debugger.log(string: "Could not extract name string from event info", logType: .failure, logLevel: .minimal)
                continue
            }
            guard let narrative = eventInfo[eventNarrativeKey] as? String else {
                Debugger.log(string: "Could not extract narrative string from event info", logType: .failure, logLevel: .minimal)
                continue
            }
            
            guard let start = Date.fromSaveString(startString) else {
                Debugger.log(string: "Could not convert start date from save string", logType: .failure, logLevel: .minimal)
                continue
            }
            guard let end = Date.fromSaveString(endString) else {
                Debugger.log(string: "Could not convert end date from save string", logType: .failure, logLevel: .minimal)
                continue
            }
            
            let pictures: [UniqueID]
            
            if let pictureExtraction = eventInfo[eventPicturesKey] as? [String] {
                pictures = pictureExtraction
            } else {
                pictures = []
            }
            
            let event = Event(uniqueID: uniqueID, name: name, start: start, end: end, narrative: narrative, pictures: pictures)
            
            Debugger.log(string: "Loaded event with unique ID \(uniqueID)", logType: .success, logLevel: .verbose)
            successCount += 1
            
            DataStore.instance.storeEvent(event, saveData: false)
        }
        
        Debugger.log(string: "Loaded event info for \(successCount) events", logType: .success, logLevel: .full)
        NotificationManager.instance.postEventUpdateNotification()
    }
    
    //MARK: - Pictures
    func importNewPicture(fromURL url: URL, completion: @escaping ()->Void = { }) {
        imageManager.importSingleImage(withFileURL: url) { (image) in
            
            Debugger.log(string: "Importing image for picture at \(url)", logType: .process, logLevel: .verbose)
            
            let uniqueID = UniqueIDGenerator.instance.picture
            
            let picture = Picture(uniqueID: uniqueID, title: uniqueID, date: nil, image: image)
            
            self.saveNewImage(forPicture: picture)
            DataStore.instance.storePicture(picture)
            
            Debugger.log(string: "Imported image at \(url)", logType: .success, logLevel: .verbose)
            completion()
        }
    }
    
    func importNewPictureFromSequence(urls: [URL], index: Int, completion: @escaping ()->Void = { } ) {
        Debugger.log(string: "Image sequence import \(index)/\(urls.count)", logType: .process, logLevel: .full)
        if urls.count <= index {
            Debugger.log(string: "Image sequence import completed", logType: .success, logLevel: .full)
            completion()
            OperationQueue.main.addOperation {
                NotificationManager.instance.postPictureUpdateNotification()
            }
            self.savePictureInfo()
            return
        }
        
        importNewPicture(fromURL: urls[index]) {
            self.importNewPictureFromSequence(urls: urls, index: index + 1)
        }
    }
    
    func saveNewImage(forPicture picture: Picture) {
        imageManager.exportSingleImage(toFileURL: directoryManager.picturesDirectory, image: picture.image, name: picture.uniqueID)
    }
    
    func deleteImage(forPicture picture: Picture) {
        SaveDataManager.instance.deleteFile(atURL: picture.savePath)
    }
    
    func savePictureInfo() {
        let pictures = dataStore.pictures
        Debugger.log(string: "Saving Picture Info for \(pictures.count) pictures", logType: .process, logLevel: .verbose)
        
        var pictureDictionary = [String:Any]()
        
        for picture in pictures {
            let title = picture.title
            let uniqueID = picture.uniqueID
            
            var infoDictionary = [
                pictureTitleKey:title
            ]
            
            if let date = picture.date {
                infoDictionary.updateValue(date.toSaveString, forKey: pictureDateKey)
            }
            
            
            pictureDictionary.updateValue(infoDictionary, forKey: uniqueID)
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: pictureDictionary, options: [])
            write(data: jsonData, toURL: directoryManager.pictureInfoDirectory)
            Debugger.log(string: "Saved Picture Info for \(pictureDictionary.count) pictures. ", logType: .success, logLevel: .full)
        } catch {
            Debugger.log(string: "Could not serialize data for pictures", logType: .failure, logLevel: .minimal)
            Debugger.log(error: error)
        }
        
    }
    
    func loadPictureInfo(completion: @escaping ()->Void = { }) {
        let dictionary = read(fromURL: directoryManager.pictureInfoDirectory)
        Debugger.log(string: "Loading picture info for \(dictionary.count) pictures", logType: .process, logLevel: .verbose)
        
        let goal = dictionary.count
        var current = 0
        var successCount = 0
        
        var pictures = [Picture]()
        
        func checkForCompletion() {
            current += 1
            Debugger.log(string: "Picture Loading: \(current)/\(goal) with \(successCount) successful", logType: .process, logLevel: .verbose)
            if goal == current {
                Debugger.log(string: "Loaded picture info for \(successCount) pictures", logType: .success, logLevel: .verbose)
                NotificationManager.instance.postPictureUpdateNotification()
                completion()
            }
        }
        
        for (uniqueID, genericPicture) in dictionary {
            
            guard let pictureInfo = genericPicture as? [String:String] else {
                Debugger.log(string: "Could not convert generic picture info into dictionary", logType: .failure, logLevel: .minimal)
                checkForCompletion()
                continue
            }
            
            guard let title = pictureInfo[pictureTitleKey] else {
                Debugger.log(string: "Could not extract title from picture info", logType: .failure, logLevel: .minimal)
                checkForCompletion()
                continue
            }
            
            let date: Date?
            
            if let dateString = pictureInfo[pictureDateKey] {
                date = Date.fromSaveString(dateString)
            } else {
                date = nil
            }
            
            imageManager.importSingleImage(withFileURL: directoryManager.imageFileURL(forUniqueID: uniqueID), completion: { (image) in
                let picture = Picture(uniqueID: uniqueID, title: title, date: date, image: image)
                Debugger.log(string: "Loaded picture with uniqueID \(uniqueID)", logType: .success, logLevel: .verbose)
                OperationQueue.main.addOperation {
                    self.dataStore.storePicture(picture, saveData: false)
                }
                successCount += 1
                checkForCompletion()
            })
            
        }
        
    }
    
}

extension SaveDataManager {
    
    var allowedImageFileTypes: [String] {
        var types = ["jpeg", "jpg", "png"]
        
        for type in types {
            types.append(type.uppercased())
        }
        
        return types
    }
    
}
