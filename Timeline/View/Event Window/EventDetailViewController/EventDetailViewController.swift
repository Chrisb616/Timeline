//
//  EventDetailViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventDetailViewController: NSViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var coverPictureImageView: CoverPictureImageView!
    
    @IBOutlet weak var eventNameLabel: NSTextField!
    @IBOutlet weak var uniqueIDLabel: NSTextField!
    
    @IBOutlet var narrativeTextView: NSTextView!
    
    @IBOutlet weak var startDateLabel: NSTextField!
    @IBOutlet weak var startTimeLabel: NSTextField!
    
    @IBOutlet weak var endDateLabel: NSTextField!
    @IBOutlet weak var endTimeLabel: NSTextField!
    
    @IBOutlet weak var startDatePicker: NSDatePicker!
    @IBOutlet weak var endDatePicker: NSDatePicker!
    
    @IBOutlet weak var durationLabel: NSTextField!
    
    //MARK: - Properties
    weak var event: Event!
    
    //MARK: - IBACtions
    
    @IBAction func startDateSelected(_ sender: Any) {
        endDatePicker.minDate = startDatePicker.dateValue
        self.durationLabel.stringValue = event.dateRange.end.durationStringSince(pastDate: event.dateRange.start)
        
    }
    
    @IBAction func endDateSelected(_ sender: Any) {
        startDatePicker.maxDate = endDatePicker.dateValue
        self.durationLabel.stringValue = event.dateRange.end.durationStringSince(pastDate: event.dateRange.start)
        
    }
    
    
    //MARK: - Initialiation
    
    static func instanceFromNib(forEvent event: Event) -> EventDetailViewController {
        let vc = EventDetailViewController(nibName: NSNib.Name("EventDetailViewController"), bundle: nil)
        vc.event = event
        return vc
    }
    
    //MARK: - Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDatePicker.maxDate = event.dateRange.end
        endDatePicker.maxDate = Date()
        
        configureForEvent()
    }
    
    private func configureForEvent() {
        self.coverPictureImageView.configure(subject: event, presentingViewController: self)
        
        self.eventNameLabel.stringValue = event.name
        self.uniqueIDLabel.stringValue = event.uniqueID
        self.narrativeTextView.string = event.narrative
        
        self.startDateLabel.stringValue = event.dateRange.start.formatted(as: "MMMM dd, yyyy")
        self.startTimeLabel.stringValue = event.dateRange.start.formatted(as: "h:mma")
        
        self.endDateLabel.stringValue = event.dateRange.end.formatted(as: "MMMM dd, yyyy")
        self.endTimeLabel.stringValue = event.dateRange.end.formatted(as: "h:mma")
        
        self.startDatePicker.dateValue = event.dateRange.start
        self.endDatePicker.dateValue = event.dateRange.end
        
        self.durationLabel.stringValue = event.dateRange.end.durationStringSince(pastDate: event.dateRange.start)
    }
    
    //MARK: - Methods
    func saveEventChanges() {
        if eventNameLabel.stringValue != "" {
            event.name = eventNameLabel.stringValue
        }
        event.narrative = narrativeTextView.string
        
        event.dateRange.start = startDatePicker.dateValue
        event.dateRange.end = endDatePicker.dateValue
        
        NotificationManager.instance.postEventUpdateNotification()
        
        configureForEvent()
    }
    
    func toggleEditMode() {
        eventNameLabel.isEditable.toggle()
        narrativeTextView.isEditable.toggle()
        
        startDateLabel.isHidden.toggle()
        startTimeLabel.isHidden.toggle()
        
        endDateLabel.isHidden.toggle()
        endTimeLabel.isHidden.toggle()
        
        startDatePicker.isHidden.toggle()
        endDatePicker.isHidden.toggle()
    }
    
}
