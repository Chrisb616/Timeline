//
//  EventDetailHeaderView.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/25/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventDetailHeaderView: NSView {

    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet var narrativeTextView: NSTextView!
    @IBOutlet weak var dateRangeTextField: NSTextField!
    
    func load(event: Event) {
        self.nameTextField.stringValue = event.name
        self.narrativeTextView.string = event.narrative ?? ""
        self.dateRangeTextField.stringValue = Date.timeRangeString(start: event.start, end: event.end)
    }
    
}
