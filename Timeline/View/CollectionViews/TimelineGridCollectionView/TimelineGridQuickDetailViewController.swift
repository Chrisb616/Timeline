//
//  TimelineGridQuickDetailViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 10/15/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridQuickDetailViewController: NSViewController {
    
    var event: Event!
    
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet var narrativeTextView: NSTextView!
    
    @IBOutlet weak var editButton: NSButton!
    @IBAction func editButtonClickAction(_ sender: Any) {
        self.dismiss(nil)
        NotificationManager.instance.postShowEventDetailNotification(forEventWithUniqueID: event.uniqueID)
    }
    
    static func instanceFromNib(forEvent event: Event) -> TimelineGridQuickDetailViewController {
        let vc = TimelineGridQuickDetailViewController(nibName: NSNib.Name("TimelineGridQuickDetailViewController"), bundle: nil)
        vc.event = event
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        self.nameLabel.stringValue = event.name
        self.narrativeTextView.string = event.narrative ?? ""
    }
    
}
