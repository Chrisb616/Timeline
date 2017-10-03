//
//  MainTimelineGridViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/23/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class MainTimelineGridViewController: NSViewController {
    
    @IBOutlet weak var collectionView: TimelineGridCollectionView!
    
    @IBOutlet weak var addItemButton: NSButton!
    
    @IBAction func addItemButtonClickAction(_ sender: Any) {
        let vc = CreateTimelineItemViewController.instanceFromNib
        
        self.presentViewControllerAsSheet(vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.configure()
        configureNotifications()
    }
    
    func configureNotifications() {
        NotificationManager.instance.addMainTimelineUpdateObserver(observer: self, selector: #selector(updateCollectionView))
        NotificationManager.instance.addMergeEventNotification(observer: self, selector: #selector(promptMergeEvents(_:)))
    }
    
    @objc func promptMergeEvents(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo else { Debugger.log(string: "No user info in notification for merge events", logType: .failure, logLevel: .minimal); return }
        guard let fromId = userInfo["from"] as? UniqueID, let toId = userInfo["to"] as? UniqueID else { Debugger.log(string: "Could not find uniqueIDs for merge events", logType: .failure, logLevel: .minimal); return }
        
        guard
            let from = Timeline.main.events.with(uniqueID: fromId),
            let to = Timeline.main.events.with(uniqueID: toId)
            else { Debugger.log(string: "Could not find events for merge events", logType: .failure, logLevel: .minimal); return }
        
        let alert = NSAlert()
        alert.messageText = "Merge events?"
        alert.informativeText = "Are you sure that you would like to merge \(from.name) into \(to.name)? All moments and occurances from \(from.name) will be merged into \(to.name), and \(from.name) will be deleted."
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Merge")
        alert.addButton(withTitle: "Cancel")
        alert.icon = from.mainImage.valueOrDefault
        let res = alert.runModal()
        if res == .alertFirstButtonReturn {
            Timeline.main.mergeEvents(fromEventWithUniqueID: fromId, toEventWithUniqueID: toId)
            updateCollectionView()
        }
    }
    
    @objc func updateCollectionView() {
        collectionView.reload(events: Timeline.main.events.all)
    }
    
}
