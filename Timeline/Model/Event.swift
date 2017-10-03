//
//  Event.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Event: HasUniqueID {
    
    //MARK: - UniqueID
    
    var uniqueID: UniqueID
    
    //MARK: - Name
    
    private var _name: String?
    var name: String { return _name ?? startDate.formatted(as: "MMMM dd, yyyy")}
    
    var narrative: String?
    
    private var startDateOverride: Date?
    private var endDateOverride: Date?
    
    var startDate: Date
    var endDate: Date
    
    private var _moments = IndexedDictionary<Moment>()
    var moments: IndexedDictionary<Moment> { return _moments }
    
    var mainImage: Image
    
    static func new(withMomentDate date: Date) -> Event {
        let uniqueID = UniqueIDGenerator.instance.event
        
        let event = Event(uniqueID: uniqueID, name: nil, narrative: nil, startDateOverride: nil, endDateOverride: nil, mainImage: Image.blank)
        event.createMomentWithinEvent(atDate: date)
        
        return event
    }
    
    static func new(fromStartDate startDate: Date, endDate: Date) -> Event {
        let uniqueID = UniqueIDGenerator.instance.event
        
        let event = Event(uniqueID: uniqueID, name: nil, narrative: nil, startDateOverride: startDate, endDateOverride: endDate, mainImage: Image.blank)
        
        return event
    }
    
    init(uniqueID: UniqueID, name: String?, narrative: String?, startDateOverride: Date?, endDateOverride: Date?, mainImage: Image) {
        self.uniqueID = uniqueID
        self._name = name
        self.narrative = narrative
        self.startDateOverride = startDateOverride
        self.startDate = Date()
        self.endDateOverride = endDateOverride
        self.endDate = Date()
        self.mainImage = mainImage
        
        //recaculateDates()
    }
    
    private func createMomentWithinEvent(atDate date: Date) {
        let momentUniqueID = UniqueIDGenerator.instance.moment
        let moment = Moment(uniqueID: momentUniqueID, name: nil, narrative: nil, date: date, image: Image.blank, parentEvent: self)
        
        self.addMoment(moment)
    }
    
    func addMoment(_ moment: Moment) {
        self._moments.add(moment)
        recaculateDates()
    }
    
    func addMoments(_ moments: [Moment]) {
        self._moments.add(moments)
        recaculateDates()
    }
 
    private func recaculateDates() {
        if let firstItemDate = moments.all.chronological.first?.date {
            if let override = startDateOverride {
                startDate = firstItemDate < override ? firstItemDate : override
            } else {
                startDate = firstItemDate
            }
        }
        
        if let lastItemDate = moments.all.chronological.first?.date {
            if let override = endDateOverride {
                endDate = lastItemDate < override ? lastItemDate : override
            } else {
                endDate = lastItemDate
            }
        }
    }
    
    
    func setName(_ name: String?) {
        self._name = name
    }
    
    /*
    //MARK: - Add Items
    func addMoment(_ moment: Moment) {
        moment.parentEvent = self
        self._moments.append(moment)
        recalculateDates()
    }
    
    func addMoments(_ moments: [Moment]) {
        moments.forEach{
            $0.parentEvent = self
            self._moments.append($0)
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
    
    func mergeItem(_ event: Event) {
        self._moments.append(contentsOf: event.moments)
        self._
    }
 */
    
}
