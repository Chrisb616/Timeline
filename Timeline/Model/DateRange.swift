//
//  DateRange.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

struct DateRange {
    
    var start: Date
    var end: Date
    
    var duration: TimeInterval { return end.timeIntervalSince(start) }
    
    var allSeconds: [Date] {
        var currentSecond = start
        
        var allSeconds = [Date]()
        
        repeat {
            allSeconds.append(currentSecond)
            currentSecond.addTimeInterval(1)
        } while end > currentSecond
        
        return allSeconds
    }
}
