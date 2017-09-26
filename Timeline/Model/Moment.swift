//
//  Moment.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Moment: EventItem, TimelineItem {
    
    var uniqueID: UniqueID
    
    private var _name: String?
    var name: String { return _name ?? timelineDate.formatted(as: "MMMM dd, yyyy")}
    
    var timelineDate: Date { return date }
    var date: Date
    
    var image: NSImage { return _image ?? NSImage(named: NSImage.Name("Event")) ?? NSImage() }
    private var _image: NSImage?
    
    weak var event: Event?
    weak var occurance: Occurance?
    
    var narrative: String?
    
    static func new(date: Date) -> Moment {
        let uniqueID = UniqueIDGenerator.instance.timelineItem
        
        return Moment(uniqueID: uniqueID, date: date)
    }
    
    static func new(fromImage image: NSImage) -> Moment {
        let moment = Moment.new(date: Date())
        moment._image = image
        return moment
    }
    
    init(uniqueID: UniqueID, date: Date) {
        self.date = date
        self.uniqueID = uniqueID
    }
    
    func setName(_ name: String?) {
        self._name = name
    }
    
    func setImage(_ image: NSImage) {
        self._image = image
    }
}
