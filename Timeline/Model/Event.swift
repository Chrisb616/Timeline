//
//  Event.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Event: HasUniqueID {
    
    var name: String
    
    var uniqueID: UniqueID
    var dateRange: DateRange
    
    var narrative: String
    
    var pictures: [String:Bool]
    
    init(uniqueID: UniqueID, name: String, start: Date, end: Date, narrative: String, pictures: [UniqueID]) {
        self.uniqueID = uniqueID
        self.name = name
        self.dateRange = DateRange(start: start, end: end)
        self.narrative = narrative
        self.pictures = [:]
        
        for picture in pictures {
            self.pictures.updateValue(true, forKey: picture)
        }
    }
}
