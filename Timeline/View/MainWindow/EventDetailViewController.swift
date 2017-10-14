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
    @IBOutlet weak var toggleEditEventButton: NSButton!
    
    private var editMode: Bool = false
    
    @IBAction func backButtonClickAction(_ sender: AnyObject) {
        checkForChanges {
            returnToMainTimelinGrid()
        }
    }
    
    @IBAction func toggleEditEventClickAction(_ sender: Any) {
        editMode = !editMode
        
        if editMode {
            toggleEditEventButton.image = NSImage(named: NSImage.Name("SaveIcon"))
            collectionView.customDataSource.header?.editModeOn()
        } else {
            saveEventChanges()
            toggleEditEventButton.image = NSImage(named: NSImage.Name("EditIcon"))
            collectionView.customDataSource.header?.editModeOff()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationManager.instance.addShowEventDetailObserver(observer: self, selector: #selector(showEventDetail(_:)))
    }
    
    @objc func showEventDetail(_ notification: Notification) {
        guard let uniqueID = notification.userInfo?["eventUniqueID"] as? UniqueID else {
            Debugger.log(string: "No unique ID in notification info", logType: .failure, logLevel: .minimal)
            return
        }
        guard let event = Timeline.main.events.with(uniqueID: uniqueID) else {
            Debugger.log(string: "Timeline item with unqiueID \(uniqueID) is not an event", logType: .failure, logLevel: .minimal)
            return
        }
        
        loadEvent(event)
    }
    
    func loadEvent(_ event: Event) {
        self.event = event
        collectionView.configure(forEvent: event)
    }
    
    func returnToMainTimelinGrid() {
        NotificationManager.instance.postMainRootTabViewSwitchNotification(forTab: .mainTimleineGrid)
    }
    
    func checkForChanges(withSuccess success: ()->Void) {
        guard let header = collectionView.customDataSource.header else { Debugger.log(string: "Cannot find header in changes check", logType: .warning, logLevel: .full); return }
        guard let event = event else { Debugger.log(string: "Cannot find event in changes check", logType: .warning, logLevel: .full); return }
        
        if header.nameTextField.stringValue != event.name || header.narrativeTextView.string != (event.narrative ?? "")  {
            
            let alert = NSAlert()
            
            alert.messageText = "Save Changes?"
            alert.informativeText = "Changes have been made to \(event.name). Would you like to save those changes?"
            alert.icon = event.mainImage.valueOrDefault
            alert.alertStyle = .warning
            alert.addButton(withTitle: "Save")
            alert.addButton(withTitle: "Discard")
            alert.addButton(withTitle: "Cancel")
            let res = alert.runModal()
            if res == .alertFirstButtonReturn {
                saveEventChanges()
                success()
            } else if res == .alertSecondButtonReturn {
                success()
            }
            
        } else {
            success()
        }
    }
    
    func saveEventChanges() {
        guard let header = collectionView.customDataSource.header else { Debugger.log(string: "Cannot find header in save event", logType: .warning, logLevel: .full); return }
        guard let event = event else { Debugger.log(string: "Cannot find event in save event", logType: .warning, logLevel: .full); return }
        
        event.setName(header.nameTextField.stringValue)
        event.narrative = header.narrativeTextView.string
    }
    
}
