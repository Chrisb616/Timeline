//
//  Moment.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Moment: HasUniqueID {
    
    //MARK: - Properties
    
    var uniqueID: UniqueID
    
    private var _name: String?
    var name: String { return _name ?? date.formatted(as: "MMMM dd, yyyy")}
    
    var narrative: String?
    
    var date: Date

    var image: Image
    
    weak var parentEvent: Event!
    
    init(uniqueID: UniqueID, name: String?, narrative: String?, date: Date, image: Image, parentEvent: Event) {
        self.uniqueID = uniqueID
        self._name = name
        self.narrative = narrative
        self.date = date
        self.image = image
        self.parentEvent = parentEvent
    }
    
}
