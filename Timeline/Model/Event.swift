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
    
    //MARK: - Narrative
    
    var narrative: String?
    
    //MARK: - Dates
    
    private var startDateOverride: Date?
    private var endDateOverride: Date?
    
    var startDate: Date
    var endDate: Date
    
    //MARK: - Moments
    
    private var _moments = IndexedDictionary<Moment>()
    var moments: IndexedDictionary<Moment> { return _moments }
    
    //MARK: - Image
    
    var mainImage: Image
    
    //MARK: - Creation Methods
    
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
    
    //MARK: - Initialization
    
    private init(uniqueID: UniqueID, name: String?, narrative: String?, startDateOverride: Date?, endDateOverride: Date?, mainImage: Image) {
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
    
    //MARK: - Moment Methods
    
    func createMomentWithinEvent(atDate date: Date) {
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
    
    //MARK: - Date Methods
 
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
    
    //MARK: - Private Variable Access Methods
    
    func setName(_ name: String?) {
        self._name = name
    }
    
}
