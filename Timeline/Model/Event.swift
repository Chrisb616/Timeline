//
//  Event.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Event: TimelineItem {
    
    var uniqueID: UniqueID
    
    private var _name: String?
    var name: String { return _name ?? timelineDate.formatted(as: "MMMM dd, yyyy")}
    
    var startOverride: Date
    var endOverride: Date
    
    private var _eventItems: [EventItem]
    var eventItems: [EventItem] { return _eventItems }
    
    var timelineDate: Date { return start }
    
    var start: Date
    var end: Date
    
    init(uniqueID: UniqueID, start: Date, end: Date) {
        self.start = start
        self.startOverride = start
        self.end = end
        self.endOverride = end
        self.uniqueID = uniqueID
        self._eventItems = []
    }
    
    func addEventItem(_ eventItem: EventItem) {
        eventItem.event = self
        self._eventItems.append(eventItem)
        recalculateDates()
    }
    
    func addEventItems(_ eventItems: [EventItem]) {
        eventItems.forEach{
            $0.event = self
            self._eventItems.append($0)
        }
        recalculateDates()
    }
    
    private func recalculateDates() {
        if let firstItem = eventItems.chronological.first {
            start = firstItem.timelineDate < startOverride ? firstItem.timelineDate : startOverride
        }
        
        if let lastItem = eventItems.chronological.last {
            end = lastItem.timelineDate > endOverride ? lastItem.timelineDate : endOverride
        }
    }
    
    
}
