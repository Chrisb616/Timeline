//
//  TimelineGridCollectionViewQuickEditViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 10/14/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewQuickEditViewController: NSViewController {
    
    @IBOutlet weak var eventNameTextField: NSTextField!
    @IBOutlet weak var startDatePicker: NSDatePicker!
    @IBOutlet weak var endDatePicker: NSDatePicker!
    
    weak var event: Event!
    
    static func instanceFromNib(forEvent event: Event) -> TimelineGridCollectionViewQuickEditViewController {
        let vc = TimelineGridCollectionViewQuickEditViewController(nibName: NSNib.Name("TimelineGridCollectionViewQuickEditViewController"), bundle: nil)
        vc.event = event
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventNameTextField.stringValue = event.name
        startDatePicker.dateValue = event.startDate
        endDatePicker.dateValue = event.endDate
    }
    
}
