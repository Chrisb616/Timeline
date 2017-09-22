//
//  Array.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

extension Array where Element == TimelineItem {
    
    var chronological: [Element] {
        return self.sorted{ $0.timelineDate < $1.timelineDate }
    }
    
    var chronologicalReversed: [Element] {
        return self.sorted{ $0.timelineDate > $1.timelineDate }
    }
    
}

extension Array where Element == EventItem {
    
    var chronological: [Element] {
        return self.sorted{ $0.timelineDate < $1.timelineDate }
    }
    
    var chronologicalReversed: [Element] {
        return self.sorted{ $0.timelineDate > $1.timelineDate }
    }
    
}
