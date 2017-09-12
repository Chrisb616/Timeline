//
//  EventsCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventsCollectionViewItem: NSCollectionViewItem {
    
    weak var event: Event?
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func load(event: Event) {
        self.titleLabel.stringValue = event.name
        self.event = event
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        if event.clickCount > 1 {
            guard let event = self.event else {
                Debugger.log(string: "No event found for collection view item", logType: .warning, logLevel: .full)
                return
            }
            let eventWindowController = EventWindowController.loadFor(event: event)
            MainWindowController.instance.eventWindowController = eventWindowController
            eventWindowController.showWindow(nil)
        }
    }
    
}
