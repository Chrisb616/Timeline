//
//  Timeline.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/30/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Timeline {
    
    //MARK: - Instance
    
    static var main = Timeline()
    
    //MARK: - Properties
    
    var events = IndexedDictionary<Event>()
    var moments = IndexedDictionary<Moment>()
    
    //MARK: - Methods
    
    func mergeEvents(fromEventWithUniqueID uniqueIDOne: UniqueID, toEventWithUniqueID uniqueIDTwo: UniqueID) {
        guard
            let eventOne = events.with(uniqueID: uniqueIDOne),
            let eventTwo = events.with(uniqueID: uniqueIDTwo)
            else { return }
        
        eventTwo.addMoments(eventOne.moments)
        
        events.remove(eventOne)
        
    }
    
}
