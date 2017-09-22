//
//  Moment.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Moment: EventItem, TimelineItem {
    
    var uniqueID: UniqueID
    
    private var _name: String?
    var name: String { return _name ?? timelineDate.formatted(as: "MMMM dd, yyyy")}
    
    var timelineDate: Date { return date }
    var date: Date
    
    var imageURL: URL?
    
    weak var event: Event?
    weak var occurance: Occurance?
    
    var narrative: String?
    
    init(uniqueID: UniqueID, date: Date) {
        self.date = date
        self.uniqueID = uniqueID
    }
    
}
