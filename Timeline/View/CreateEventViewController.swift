//
//  CreateEventViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class CreateEventViewController: NSViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var startDatePicker: NSDatePicker!
    @IBOutlet weak var endDatePicker: NSDatePicker!
    @IBOutlet weak var narrativeTextView: NSTextView!
    
    @IBOutlet weak var durationLabel: NSTextField!
    
    //MARK: - Actions
    @IBAction func startDateSelected(_ sender: Any) {
        endDatePicker.minDate = startDatePicker.dateValue
        updateDuration()
    }
    
    @IBAction func endDateSelected(_ sender: Any) {
        startDatePicker.maxDate = endDatePicker.dateValue
        updateDuration()
    }
    
    @IBAction func saveEvent(_ sender: Any) {
        if nameTextField.stringValue == "" { return }
        if narrativeTextView.string == "Narrative" { return }
        
        let event = Event(uniqueID: UniqueIDGenerator.instance.event, name: nameTextField.stringValue, start: startDatePicker.dateValue, end: endDatePicker.dateValue, narrative: narrativeTextView.string, pictureUniqueIDs: [], coverPictureUniqueID: nil)
        
        DataStore.instance.storeEvent(event)
        NotificationManager.instance.postEventUpdateNotification()
        dismiss(nil)
    }
    
    //MARK: - Initialization and Lifecycle
    static var instanceFromNib: CreateEventViewController {
        return CreateEventViewController(nibName: NSNib.Name("CreateEventViewController"), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDuration()
        
        startDatePicker.dateValue = Date()
        startDatePicker.maxDate = Date()
        endDatePicker.dateValue = Date()
        endDatePicker.maxDate = Date()
    }
    
    //MARK: - Methods
    func updateDuration() {
        durationLabel.stringValue = endDatePicker.dateValue.durationStringSince(pastDate: startDatePicker.dateValue)
        
    }
    
}
