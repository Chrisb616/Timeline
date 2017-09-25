//
//  TimelineGridCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/23/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewItem: NSCollectionViewItem {
    
    weak var timelineItem: TimelineItem!

    @IBOutlet weak var timelineItemImageView: NSImageView!
    @IBOutlet weak var timelineItemNameTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    
    }
    
    func load(timelineItem: TimelineItem) {
        self.timelineItem = timelineItem
        self.timelineItemNameTextField.stringValue = timelineItem.name
    }
    
    override func mouseDown(with event: NSEvent) {
        if let event = timelineItem as? Event {
            NotificationManager.instance.postShowEventDetailNotification(forEventWithUniqueID: event.uniqueID)
        }
        
    }
    
}
