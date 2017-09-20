//
//  TimelineGridCollectionViewDataSource.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/17/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewDataSource: NSObject, NSCollectionViewDataSource {
    
    private var _timelineItems = [TimelineItem]()
    
    func load(timelineItems: [TimelineItem]) {
        self._timelineItems = timelineItems
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return _timelineItems.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let collectionViewItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TimelineGridCollectionViewItem"), for: indexPath)
        
        guard let timelineGridCollectionViewItem = collectionViewItem as? TimelineGridCollectionViewItem else  {
            Debugger.log(string: "Could not convert collection view item to TimelineGridCollectionViewItem type", logType: .failure, logLevel: .minimal)
            
            return collectionViewItem
        }
        
        let currentTimelineItem = _timelineItems[indexPath.item]
        
        timelineGridCollectionViewItem.load(currentTimelineItem)
        
        return timelineGridCollectionViewItem
        
    }
    
}
