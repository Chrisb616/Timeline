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
    
    static func new(withMomentDate date: Date, image: Image?) -> Event {
        let uniqueID = UniqueIDGenerator.instance.event
        
        let event = Event(uniqueID: uniqueID, name: nil, narrative: nil, startDateOverride: nil, endDateOverride: nil, mainImage: Image.blank)
        event.createMomentWithinEvent(atDate: date, image: image)
        
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
    
    func createMomentWithinEvent(atDate date: Date, image: Image?) {
        let momentUniqueID = UniqueIDGenerator.instance.moment
        
        let usedImage = image ?? Image.blank
        
        let moment = Moment(uniqueID: momentUniqueID, name: nil, narrative: nil, date: date, image: usedImage, parentEvent: self)
        
        self.addMoment(moment)
    }
    
    func addMoment(_ moment: Moment) {
        self._moments.add(moment)
        moment.parentEvent = self
        recaculateDates()
    }
    
    func addMoments(_ moments: [Moment]) {
        for moment in moments {
            moment.parentEvent = self
            self._moments.add(moment)
        }
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
        
        if let lastItemDate = moments.all.chronologicalReversed.first?.date {
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
    
    func setStartDate(_ date: Date?) {
        self.startDateOverride = date
    }
    
    func setEndDate(_ date: Date?) {
        self.endDateOverride = date
    }
    
}

extension Event {
    
    //MARK: - Computed Properties
    
    var dateRangeString: String {
        if startDate.year == endDate.year {
            
            if startDate.month == endDate.month {
                
                if startDate.day == endDate.day {
                    
                    if startDate.hour == endDate.hour && startDate.minute == endDate.minute {
                        
                        return startDate.formatted(as: "d MMM, YYYY hh:mma")
                        
                    } else {
                        
                        return startDate.formatted(as: "d MMM, YYYY hh:mma") + " - " + endDate.formatted(as: "hh:mma")
                    }
                    
                } else {
                    
                    return startDate.formatted(as: "d") + " - " + endDate.formatted(as: "d MMM, YYYY")
                    
                }
                
            } else {
                
                return startDate.formatted(as: "d MMM") + " - " + endDate.formatted(as: "d MMM, YYYY")
                
            }
            
        } else {
            
            return startDate.formatted(as: "d MMM, YYYY") + " - " + endDate.formatted(as: "d MMM, YYYY")
        }
    }
    
}
