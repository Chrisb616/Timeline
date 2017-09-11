//
//  TimelineTests.swift
//  TimelineTests
//
//  Created by Christopher Boynton on 9/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import XCTest
@testable import Timeline

class TimelineTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    /*
    func testAddAndQueryEvent() {
        let timeline = Timeline()
        
        let startDate = Date.fromComponents(year: 2017, month: 9, day: 6, hour: 3, minute: 34, second: 0)!
        let endDate = Date.fromComponents(year: 2017, month: 9, day: 6, hour: 4, minute: 4, second: 0)!
        
        let event = Event(uniqueID: "test", start: startDate, end: endDate)
        
        timeline.addEvent(event)
        
        let query = timeline.queryEventIDs(forSecond: 5, minute: 37, hour: 3, day: 6, month: 9, year: 2017)
        
        assert(query.count == 1)
    }
    
    func testRemoveAndQueryEvent() {
        
        let timeline = Timeline()
        
        let eventOneStartDate = Date.fromComponents(year: 2017, month: 9, day: 6, hour: 3, minute: 34, second: 0)!
        let eventOneEndDate = Date.fromComponents(year: 2017, month: 9, day: 6, hour: 4, minute: 4, second: 0)!
        
        let eventTwoStartDate = Date.fromComponents(year: 2017, month: 9, day: 6, hour: 2, minute: 34, second: 0)!
        let eventTwoEndDate = Date.fromComponents(year: 2017, month: 9, day: 6, hour: 5, minute: 4, second: 0)!
        
        let eventOne = Event(uniqueID: "eventOne", start: eventOneStartDate, end: eventOneEndDate)
        let eventTwo = Event(uniqueID: "eventTwo", start: eventTwoStartDate, end: eventTwoEndDate)
        
        timeline.addEvent(eventOne)
        timeline.addEvent(eventTwo)
        
        let preliminaryQuery = timeline.queryEventIDs(forSecond: 5, minute: 37, hour: 3, day: 6, month: 9, year: 2017)
        
        assert(preliminaryQuery.count == 2)
        
        timeline.removeEvent(eventTwo)
        
        let finalQuery = timeline.queryEventIDs(forSecond: 5, minute: 37, hour: 3, day: 6, month: 9, year: 2017)
        
        assert(finalQuery.count == 1)
        
    }
    */
}
