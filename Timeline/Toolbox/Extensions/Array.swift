//
//  Array.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

extension Array where Element == Event {
    
    var chronological: [Event] {
        return self.sorted{ $0.startDate < $1.startDate }
    }
    
    var chronologicalReversed: [Event] {
        return self.sorted{ $0.startDate > $1.startDate }
    }
    
}

extension Array where Element == Moment {
    
    var chronological: [Moment] {
        return self.sorted{ $0.date < $1.date }
    }
    
    var chronologicalReversed: [Moment] {
        return self.sorted{ $0.date > $1.date }
    }
    
}
