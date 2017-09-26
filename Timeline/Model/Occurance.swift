//
//  Occurance.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Occurance: EventItem {
    
    
    var uniqueID: UniqueID
    
    private var _name: String?
    var name: String { return _name ?? timelineDate.formatted(as: "MMMM dd, yyyy")}
    
    var timelineDate: Date { return start }
    
    var narrative: String?
    
    weak var event: Event?
    
    private var _moments = [Moment]()
    var moments: [Moment] { return _moments }
    
    var startOverride: Date
    var endOverride: Date
    
    var start: Date
    var end: Date
    
    private var _image: NSImage?
    var image: NSImage { return _image ?? NSImage(named: NSImage.Name("Event")) ?? NSImage()}
    
    init(inEvent event: Event, uniqueID: UniqueID, start: Date, end: Date) {
        self.uniqueID = uniqueID
        self.event = event
        self.start = start
        self.startOverride = start
        self.end = end
        self.endOverride = end
    }
    
    func addMoment(_ moment: Moment) {
        moment.occurance = self
        self._moments.append(moment)
        recalculateDates()
    }
    func addMoments(_ moments: [Moment]) {
        moments.forEach{
            $0.occurance = self
            self._moments.append($0)
        }
        self._moments.append(contentsOf: moments)
        recalculateDates()
    }
    
    private func recalculateDates() {
        if let firstMoment = moments.first {
            start = firstMoment.date < startOverride ? firstMoment.date : startOverride
        }
        if let lastMoment = moments.last {
            end = lastMoment.date > endOverride ? lastMoment.date : endOverride
        }
    }
    
}
