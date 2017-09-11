//
//  Array<Event>.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

extension Array where Element == Event {
    
    var chronological: [Event] {
        return self.sorted{ $0.dateRange.start < $1.dateRange.start }
    }
    
    var chronologicalReversed: [Event] {
        return self.sorted{ $0.dateRange.start > $1.dateRange.end }
    }
    
}
