//
//  DataStore.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class DataStore {
    
    private init() {}
    static let instance = DataStore()
    
    //MARK: - Event Properties
    private var eventDictionary = IndexedDictionary<Event>()
    private var timeline = Timeline()
    
    var events: [Event] { return eventDictionary.all }
    
    //MARK: - Picture Properties
    private var pictureDictionary = IndexedDictionary<Picture>()
    
    var pictures: [Picture] { return pictureDictionary.all }
    
    //MARK: - Event Methods
    func retrieveEvent(withUniqueID uniqueID: UniqueID) -> Event? {
        if let event = eventDictionary.with(uniqueID: uniqueID) {
            return event
        } else {
            Debugger.log(string: "Could not find event with unique ID \(uniqueID)", logType: .failure, logLevel: .full)
            return nil
        }
    }
    
    func retrieveEvents(withUniqueIDs uniqueIDs: [UniqueID]) -> [Event] {
        var events = [Event]()
        
        for uniqueID in uniqueIDs {
            
            guard let event = retrieveEvent(withUniqueID: uniqueID) else { continue }
            
            events.append(event)
            
        }
        
        return events
    }
    
    func storeEvent(_ event: Event, saveData: Bool = true) {
        if eventDictionary.with(uniqueID: event.uniqueID) != nil {
            Debugger.log(string: "Overwriting event with unique ID \(event.uniqueID)", logType: .warning, logLevel: .full)
        }
        
        eventDictionary.add(event)
        timeline.addEvent(event)
        
        if saveData { SaveDataManager.instance.saveEventInfo() }
    }
    
    func storeEvents(_ events: [Event], saveData: Bool = true) {
        for event in events {
            storeEvent(event, saveData: saveData)
        }
    }
    
    func removeEvent(_ event: Event, saveData: Bool = true) {
        removeEvent(withUniqueID: event.uniqueID, saveData: saveData)
    }
    
    func removeEvent(withUniqueID uniqueID: UniqueID, saveData: Bool = true) {
        eventDictionary.remove(itemWithUniqueID: uniqueID)
        
        if saveData { SaveDataManager.instance.saveEventInfo() }
    }
    
    //MARK: - Picture Methods
    func retrievePicture(withUniqueID uniqueID: UniqueID) -> Picture? {
        if let picture = pictureDictionary.with(uniqueID: uniqueID) {
            return picture
        } else {
            Debugger.log(string: "Could not find picture with unique ID \(uniqueID)", logType: .failure, logLevel: .full)
            return nil
        }
    }
    
    func retrievePictures(withUniqueIDs uniqueIDs: [UniqueID]) -> [Picture] {
        var pictures = [Picture]()
        
        for uniqueID in uniqueIDs {
            guard let picture = retrievePicture(withUniqueID: uniqueID) else { continue }
            
            pictures.append(picture)
        }
        
        return pictures
    }
    
    func storePicture(_ picture: Picture, saveData: Bool = true) {
        if pictureDictionary.with(uniqueID: picture.uniqueID) != nil {
            Debugger.log(string: "Overwriting picture with unique ID \(picture.uniqueID)", logType: .warning, logLevel: .full)
        }
        
        pictureDictionary.add(picture)
        Debugger.log(string: "Storing picture with unique ID \(picture.uniqueID) into datastore. Datastore now contains: \(pictureDictionary.count) pictures. ", logType: .process, logLevel: .verbose)
        
        if saveData { SaveDataManager.instance.savePictureInfo() }
    }
    
    func storePictures(_ pictures: [Picture], saveData: Bool = true) {
        for picture in pictures {
            storePicture(picture, saveData: saveData)
        }
    }
}
