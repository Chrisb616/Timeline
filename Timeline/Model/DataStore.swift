//
//  DataStore.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/23/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class DataStore {
    
    static var instance = DataStore()
    private init() {}
    
    var timelineItems = [UniqueID: TimelineItem]()
    
}
