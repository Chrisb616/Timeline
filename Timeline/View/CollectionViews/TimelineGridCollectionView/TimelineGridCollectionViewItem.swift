//
//  TimelineGridCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/23/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewItem: NSCollectionViewItem {
    
    weak var event: Event!

    @IBOutlet weak var eventImageView: NSImageView!
    @IBOutlet weak var eventNameTextField: NSTextField!
    @IBOutlet weak var eventDateTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    
    }
    
    func load(event: Event) {
        self.eventImageView.image = event.mainImage.valueOrDefault
        self.event = event
        self.eventNameTextField.stringValue = event.name
        self.eventDateTextField.stringValue = event.dateRangeString
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if event.clickCount == 2 {
            NotificationManager.instance.postShowEventDetailNotification(forEventWithUniqueID: self.event.uniqueID)
        }
    }
    
    override func rightMouseDown(with event: NSEvent) {
        super.rightMouseDown(with: event)
        presentViewController(TimelineGridQuickDetailViewController.instanceFromNib(forEvent: self.event), asPopoverRelativeTo: eventImageView.frame, of: eventImageView, preferredEdge: NSRectEdge.minY, behavior: .transient)
        
    }
    
}
