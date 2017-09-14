//
//  Event.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Event: HasUniqueID, HasCoverPicture {
    
    var name: String
    
    var uniqueID: UniqueID
    var dateRange: DateRange
    
    var narrative: String
    
    var pictureUniqueIDs: [UniqueID:Bool]
    
    var coverPictureUniqueID: UniqueID?
    
    init(uniqueID: UniqueID, name: String, start: Date, end: Date, narrative: String, pictureUniqueIDs: [UniqueID], coverPictureUniqueID: UniqueID?) {
        self.uniqueID = uniqueID
        self.name = name
        self.dateRange = DateRange(start: start, end: end)
        self.narrative = narrative
        self.pictureUniqueIDs = [:]
        
        self.coverPictureUniqueID = coverPictureUniqueID
        
        for picture in pictureUniqueIDs {
            self.pictureUniqueIDs.updateValue(true, forKey: picture)
        }
    }
}
