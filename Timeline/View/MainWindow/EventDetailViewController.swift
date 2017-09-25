//
//  EventDetailViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/25/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventDetailViewController: NSViewController {
    
    private weak var event: Event?
    @IBOutlet weak var collectionView: EventDetailCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationManager.instance.addShowEventDetailObserver(observer: self, selector: #selector(showEventDetail(_:)))
    }
    
    @objc func showEventDetail(_ notification: Notification) {
        guard let uniqueID = notification.userInfo?["eventUniqueID"] as? UniqueID else {
            Debugger.log(string: "No unique ID in notification info", logType: .failure, logLevel: .minimal)
            return
        }
        guard let timelineItem = DataStore.instance.timelineItems[uniqueID] else {
            Debugger.log(string: "No timeline item with uniqueID \(uniqueID)", logType: .failure, logLevel: .minimal)
            return
        }
        guard let event = timelineItem as? Event else {
            Debugger.log(string: "Timeline item with unqiueID \(uniqueID) is not an event", logType: .failure, logLevel: .minimal)
            return
        }
        
        loadEvent(event)
    }
    
    func loadEvent(_ event: Event) {
        self.event = event
        collectionView.configure(forEvent: event)
    }
    
}
