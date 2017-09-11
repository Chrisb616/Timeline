//
//  EventsViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventsViewController: NSViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var collectionViewFlowLayout: NSCollectionViewFlowLayout!
    
    var events = [Event]()
    
    //MARK: - Instantiation
    static var instanceFromNib: EventsViewController {
        return EventsViewController(nibName: NSNib.Name("EventsViewController"), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.events = DataStore.instance.events.chronological
        
        configureCollectionView()
        
        NotificationManager.instance.addEventUpdateObserver(observer: self, selector: #selector(update))
    }
    
    @objc func update() {
        self.events = DataStore.instance.events.chronological
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        collectionViewFlowLayout.itemSize = NSSize(width: 100, height: 140)
        collectionViewFlowLayout.sectionInset = NSEdgeInsetsMake(10, 10, 10, 10)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        collectionView.wantsLayer = true
        
        collectionView.layer = CALayer()
        collectionView.layer?.backgroundColor = NSColor.white.cgColor
        
    }
}

extension EventsViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "EventsCollectionViewItem"), for: indexPath)
    
        
        guard let collectionViewItem = item as? EventsCollectionViewItem else { return item }
        
        collectionViewItem.load(event: events[indexPath.item])
        
        return collectionViewItem
    }
    
}

