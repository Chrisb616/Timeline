//
//  Event.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Event: HasUniqueID {
    
    //MARK: - Stored Properties
    
    var uniqueID: UniqueID
    var narrative: String?
    
    var startDateOverride: Date?
    var endDateOverride: Date?
    
    var mainImage: Image
    
    private var _name: String?
    
    private var _startDate: Date
    private var _endDate: Date
    
    private var _momentIDs = [UniqueID:Bool]()
    
    //MARK: - Initialization
    
    private init(uniqueID: UniqueID, name: String?, narrative: String?, startDateOverride: Date?, endDateOverride: Date?, mainImage: Image) {
        self.uniqueID = uniqueID
        self._name = name
        self.narrative = narrative
        self.startDateOverride = startDateOverride
        self._startDate = Date()
        self.endDateOverride = endDateOverride
        self._endDate = Date()
        self.mainImage = mainImage
        
        //recaculateDates()
    }
    
    //MARK: - Public Initialization Methods
    
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
    
    //MARK: - Moment Methods
    
    func createMomentWithinEvent(atDate date: Date, image: Image?) {
        let momentUniqueID = UniqueIDGenerator.instance.moment
        
        let usedImage = image ?? Image.blank
        
        let moment = Moment(uniqueID: momentUniqueID, name: nil, narrative: nil, date: date, image: usedImage, parentEvent: self)
        
        self.addMoment(moment)
    }
    
    func addMoment(_ moment: Moment) {
        Timeline.main.moments.add(moment)
        self._momentIDs.updateValue(true, forKey: moment.uniqueID)
        moment.parentEvent = self
        recaculateDates()
    }
    
    func addMoments(_ moments: [Moment]) {
        for moment in moments {
            moment.parentEvent = self
            Timeline.main.moments.add(moment)
            self._momentIDs.updateValue(true, forKey: moment.uniqueID)
        }
        recaculateDates()
    }
    
    //MARK: - Date Methods
 
    private func recaculateDates() {
        
        if let firstItemDate = moments.chronological.first?.date {
            if let override = startDateOverride {
                _startDate = firstItemDate < override ? firstItemDate : override
            } else {
                _startDate = firstItemDate
            }
        }
        
        if let lastItemDate = moments.chronologicalReversed.first?.date {
            if let override = endDateOverride {
                _endDate = lastItemDate < override ? lastItemDate : override
            } else {
                _endDate = lastItemDate
            }
        }
        
    }
    
    //MARK: - Public Access Get Properties
    
    var name: String {
        return _name ?? startDate.formatted(as: "MMMM dd, yyyy")
        
    }
    
    var startDate: Date { return _startDate }
    var endDate: Date { return _endDate }

    var moments: [Moment] {
        var moments = [Moment]()
        
        for uniqueID in _momentIDs.keys {
            guard let moment = Timeline.main.moments.with(uniqueID: uniqueID) else {
                Debugger.log(string: "Could not find moment with ID \(uniqueID) when listing moments for event with ID \(uniqueID)", logType: .failure, logLevel: .minimal)
                continue
            }
            
            moments.append(moment)
        }
        
        return moments
    }
    
    //MARK: - Public Access Set Methods
    
    func setName(_ name: String?) {
        self._name = name
    }
    
    //MARK: - Save Info
    
    var saveDictionary: [String: Any] {
        
        var saveDictionary = [String: Any]()
        
        if let name = _name {
            saveDictionary.updateValue(name, forKey: "name")
        }
        
        if let startDateOverride = startDateOverride {
            saveDictionary.updateValue(startDateOverride, forKey: "startDateOverride")
        }
        
        if let endDateOverride = endDateOverride {
            saveDictionary.updateValue(endDateOverride, forKey: "endDateOverride")
        }
        
        if let narrative = narrative {
            saveDictionary.updateValue(narrative, forKey: "narrative")
        }
        
        saveDictionary.updateValue(moments, forKey: "moments")
        
        return [uniqueID : saveDictionary]
        
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
