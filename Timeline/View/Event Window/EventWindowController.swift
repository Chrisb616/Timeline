//
//  EventWindowController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventWindowController: NSWindowController {
    
    //MARK: - Initialization
    static func loadFor(event: Event) -> EventWindowController {
        let windowController = EventWindowController(windowNibName: NSNib.Name("EventWindowController"))
        windowController.event = event
        windowController.window?.title = event.name
        return windowController
    }
    
    //MARK: - View Controllers
    var tabViewController = NSTabViewController()
    
    var eventDetailViewController: EventDetailViewController!
    var eventPicturesViewController: EventPicturesViewController!
    
    //MARK: - Properties
    weak var event: Event!
    
    var isInEditMode: Bool = false
    
    //MARK: - Lifecycle
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.delegate = self
        
        configureTabViewController()
    }
    
    override func close() {
        self.close()
        MainWindowController.instance.eventWindowController = nil
    }
    
    
    //MARK: - Toolbar
    
    //MARK: IBOutlets
    @IBOutlet weak var editToolbarItem: NSToolbarItem!
    
    //MARK: IBActions
    @IBAction func switchToEventInfoTab(_ sender: Any) {
        switchTab(to: .detail)
    }
    
    @IBAction func switchToEventPicturesTab(_ sender: Any) {
        switchTab(to: .pictures)
    }
    
    @IBAction func deleteEvent(_ sender: Any) {
        let alert = NSAlert.init()
        alert.icon = NSImage(named: NSImage.Name("Dance"))
        alert.messageText = "Are you sure you want to delete the event \(self.event.name)?"
        alert.addButton(withTitle: "Cancel")
        alert.addButton(withTitle: "Delete")
        alert.beginSheetModal(for: window!) { (response) in
            if response == NSApplication.ModalResponse.alertSecondButtonReturn {
                DataStore.instance.removeEvent(self.event)
                NotificationManager.instance.postEventUpdateNotification()
                MainWindowController.instance.eventWindowController?.close()
                MainWindowController.instance.eventWindowController = nil
            }
        }
    }
    
    @IBAction func editEvent(_ sender: Any) {
        if isInEditMode {
            saveEvent()
        } else {
            allowEventEditing()
        }
    }
    
    //MARK: - Event Editing
    
    func allowEventEditing() {
        editToolbarItem.image = NSImage.init(named: NSImage.Name("Save"))
        editToolbarItem.label = "Save"
        
        switchTab(to: .detail)
        
        eventDetailViewController.eventNameLabel.isEditable = true
        
        isInEditMode = !isInEditMode
    }
    
    func saveEvent() {
        editToolbarItem.image = NSImage.init(named: NSImage.Name("Pencil"))
        
        eventDetailViewController.eventNameLabel.isEditable = false
        
        eventDetailViewController.saveEventChanges()
        SaveDataManager.instance.saveEventInfo()
        NotificationManager.instance.postEventUpdateNotification()
        
        isInEditMode = !isInEditMode
    }
    
    //MARK: - Tab View Controller
    
    enum TabViewControllerItem {
        case detail
        case pictures
        
        var index: Int {
            switch self {
            case .detail: return 0
            case .pictures: return 1
            }
        }
    }
    
    func configureTabViewController() {
        tabViewController.view.wantsLayer = true
        tabViewController.tabStyle = .unspecified
        
        eventDetailViewController = EventDetailViewController.instanceFromNib(forEvent: event)
        eventPicturesViewController = EventPicturesViewController.instanceFromNib(forEvent: event)
        
        tabViewController.addChildViewController(eventDetailViewController)
        tabViewController.addChildViewController(eventPicturesViewController)
        
        self.window?.contentViewController = tabViewController
    }
    
    func switchTab(to item: TabViewControllerItem) {
        if isInEditMode {
            let alert = NSAlert()
            alert.icon = NSImage(named: NSImage.Name("Pencil"))
            alert.messageText = "You are currently editing this event. Would you like to save your changes?"
            alert.addButton(withTitle: "Cancel")
            alert.addButton(withTitle: "Don't Save")
            alert.addButton(withTitle: "Save")
            let response = alert.runModal()
            switch response {
            case .alertFirstButtonReturn:
                break
            case .alertSecondButtonReturn:
                tabViewController.selectedTabViewItemIndex = item.index
                saveEvent()
            case .alertThirdButtonReturn:
                saveEvent()
                tabViewController.selectedTabViewItemIndex = item.index
            default:
                break
            }
        } else {
            tabViewController.selectedTabViewItemIndex = item.index
        }
    }
    
    
}

//MARK: - Window Delegate
extension EventWindowController: NSWindowDelegate {
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        if isInEditMode {
            let alert = NSAlert()
            alert.icon = NSImage(named: NSImage.Name("Pencil"))
            alert.messageText = "You are currently editing this event. Would you like to save your changes?"
            alert.addButton(withTitle: "Cancel")
            alert.addButton(withTitle: "Don't Save")
            alert.addButton(withTitle: "Save")
            let response = alert.runModal()
            switch response {
            case .alertFirstButtonReturn:
                return false
            case .alertSecondButtonReturn:
                return true
            case .alertThirdButtonReturn:
                saveEvent()
                return true
            default:
                return false
            }
        } else {
            return true
        }
    }
    
}
