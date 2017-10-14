//
//  TimelineGridCollectionViewDataSource.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/23/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewDataSource: NSObject, NSCollectionViewDataSource {
    
    weak var timeline: Timeline!
    
    var chronological = [Event]()
    
    func reloadChronlogicalItems() {
        chronological = timeline.events.all.chronological
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return chronological.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: .init("TimelineGridCollectionViewItem"), for: indexPath)
        
        guard let collectionViewItem = item as? TimelineGridCollectionViewItem else {
            Debugger.log(string: "Cannot convert collection view itme into TimelineGridCollectionViewItem", logType: .failure, logLevel: .minimal)
            return item
        }
        
        let event = chronological[indexPath.item]
        
        collectionViewItem.load(event: event)
        
        return collectionViewItem
    }
 
}
