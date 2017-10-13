//
//  EventDetailCollectionViewDataSource.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/25/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventDetailCollectionViewDataSource: NSObject, NSCollectionViewDataSource {
    
    weak var event: Event!
    var header: EventDetailHeaderView?
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return event.moments.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let collectionViewItem = NSCollectionViewItem(nibName: NSNib.Name("TimelineGridCollectionViewItem"), bundle: nil)
        
        return collectionViewItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        switch kind {
        case .sectionHeader:
            guard let header = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: .init("EventDetailHeaderView"), for: indexPath) as? EventDetailHeaderView else { Debugger.log(string: "Cannot load header for event detail", logType: .failure, logLevel: .minimal); return NSView()}
            self.header = header
            header.load(event: event)
            return header
        default:
            return NSView()
        }
    }
}
