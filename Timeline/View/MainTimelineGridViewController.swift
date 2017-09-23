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
    }
    
    @objc func updateCollectionView() {
        collectionView.reload(timelineItems: DataStore.instance.timelineItems.valuesArray)
    }
    
}
