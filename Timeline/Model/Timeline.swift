//
//  Timeline.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/30/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Timeline {
    
    static var main = Timeline()
    
    var events = IndexedDictionary<Event>()
    
    func mergeEvents(fromEventWithUniqueID uniqueIDOne: UniqueID, toEventWithUniqueID uniqueIDTwo: UniqueID) {
        guard
            let eventOne = events.with(uniqueID: uniqueIDOne),
            let eventTwo = events.with(uniqueID: uniqueIDTwo)
            else { return }
        
        eventTwo.addMoments(eventOne.moments.all)
        
        events.remove(eventOne)
        
    }
    
}
