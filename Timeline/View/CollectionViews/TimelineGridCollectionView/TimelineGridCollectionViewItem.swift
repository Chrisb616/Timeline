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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    
    }
    
    func load(event: Event) {
        self.eventImageView.image = event.mainImage.valueOrDefault
        self.event = event
        self.eventNameTextField.stringValue = event.name
    
    }
    
    override func mouseDown(with event: NSEvent) {
        NotificationManager.instance.postShowEventDetailNotification(forEventWithUniqueID: self.event.uniqueID)
    }
    
}
