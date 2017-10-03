//
//  CreateTimelineItemViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/23/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class CreateTimelineItemViewController: NSViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: NSSegmentedControl!
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var narrativeTextField: NSTextField!
    
    @IBOutlet weak var startDateLabel: NSTextField!
    @IBOutlet weak var endDateLabel: NSTextField!
    
    @IBOutlet weak var startDatePicker: NSDatePicker!
    @IBOutlet weak var endDatePicker: NSDatePicker!
    
    @IBOutlet weak var saveButton: NSButton!
    
    //MARK: - Instantiation
    static var instanceFromNib: CreateTimelineItemViewController {
        return CreateTimelineItemViewController(nibName: NSNib.Name("CreateTimelineItemViewController"), bundle: nil)
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSegmentedControl()
        configureSaveButton()
        configureDatePickers()
    }
    
    //MARK: - Configuration
    func configureSegmentedControl() {
        segmentedControl.action = #selector(segmentedControlSwitched)
    }
    
    func configureSaveButton() {
        saveButton.action = #selector(saveButtonClickAction)
    }
    
    func configureDatePickers() {
        startDatePicker.dateValue = Date()
        endDatePicker.dateValue = Date()
    }
    
    //MARK: - Selector Actions
    @objc func segmentedControlSwitched() {
        if segmentedControl.selectedSegment == 0 {
            formatForEventCreation()
        } else {
            formatForMomentCreation()
        }
    }
    
    @objc func saveButtonClickAction() {
        if segmentedControl.selectedSegment == 0 {
            createEvent()
        } else {
            createMoment()
        }
        self.dismiss(self)
    }
    
    //MARK: - Other Methods
    func formatForEventCreation() {
        endDateLabel.isHidden = false
        endDatePicker.isHidden = false
        
        nameTextField.placeholderString = "Event Name (Optional)"
        narrativeTextField.placeholderString = "Event Narrative (Optional)"
        
        startDateLabel.stringValue = "Start"
        
    }
    
    func formatForMomentCreation() {
        endDateLabel.isHidden = true
        endDatePicker.isHidden = true
        
        nameTextField.placeholderString = "Moment Name (Optional)"
        narrativeTextField.placeholderString = "Moment Narrative (Optional)"
        
        startDateLabel.stringValue = "Date/Time"
    }
    
    func createEvent() {
        let event = Event.new(fromStartDate: startDatePicker.dateValue, endDate: endDatePicker.dateValue)
        
        if nameTextField.stringValue != "" {
            event.setName(nameTextField.stringValue)
        }
        
        if narrativeTextField.stringValue != "" {
            event.narrative = narrativeTextField.stringValue
        }
        
        Timeline.main.events.add(event)
        NotificationManager.instance.postMainTimelineUpdateNotification()
    }
    
    func createMoment() {
        let event = Event.new(withMomentDate: startDatePicker.dateValue)
        
        if nameTextField.stringValue != "" {
            event.setName(nameTextField.stringValue)
        }
        
        if narrativeTextField.stringValue != "" {
            event.narrative = narrativeTextField.stringValue
        }
        
        Timeline.main.events.add(event)
        NotificationManager.instance.postMainTimelineUpdateNotification()
    }
    
}
