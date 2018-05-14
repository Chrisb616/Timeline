//
//  EventDetailCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 10/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventDetailCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var momentImageView: NSImageView!
    
    weak var moment: Moment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func load(moment: Moment) {
        self.moment = moment
        
        self.momentImageView.image = moment.image.valueOrDefault
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if event.clickCount == 2 {
            NotificationManager.instance.postShowMomentDetailNotification(forMomentWithUniqueID: self.moment.uniqueID)
        }
    }
}
