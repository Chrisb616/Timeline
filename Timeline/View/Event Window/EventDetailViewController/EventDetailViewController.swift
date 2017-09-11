//
//  EventDetailViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventDetailViewController: NSViewController {
    
    @IBOutlet weak var eventNameLabel: NSTextField!
    
    @IBOutlet weak var uniqueIDLabel: NSTextField!
    
    weak var event: Event!
    
    @IBAction func deleteEvent(_ sender: Any) {
    }
    
    static func instanceFromNib(forEvent event: Event) -> EventDetailViewController {
        let vc = EventDetailViewController(nibName: NSNib.Name("EventDetailViewController"), bundle: nil)
        vc.event = event
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventNameLabel.isEditable = false
        
        configureForEvent()
    }
    
    private func configureForEvent() {
        self.eventNameLabel.stringValue = event.name
        self.uniqueIDLabel.stringValue = event.uniqueID
    }
    
    func saveEventChanges() {
        if eventNameLabel.stringValue != "" {
            event.name = eventNameLabel.stringValue
        }
    }
    
    
}
