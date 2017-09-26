//
//  Temporal.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

protocol Temporal {
    
    var name: String { get }
    var timelineDate: Date { get }
    var image: NSImage { get }
    
}
