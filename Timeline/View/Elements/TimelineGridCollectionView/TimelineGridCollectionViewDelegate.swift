//
//  TimelineGridCollectionViewDelegate.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/17/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewDelegate: NSObject, NSCollectionViewDelegate {
    
    //MARK: - Drag and Drop
    
    func collectionView(_ collectionView: NSCollectionView, canDragItemsAt indexes: IndexSet, with event: NSEvent) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        guard let timelineItem = (collectionView.item(at: indexPath) as? TimelineGridCollectionViewItem)?.timelineItem else {
            Debugger.log(string: "Could not find timelineItem in collection view item during drag and drop", logType: .failure, logLevel: .minimal)
            return nil
        }
        
        return timelineItem.url.nsURL
    }
    
    //MARK: - Selection
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        for indexPath in indexPaths {
            guard let item = collectionView.item(at: indexPath) else {continue}
            (item as! TimelineGridCollectionViewItem).setHighlight()
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        for indexPath in indexPaths {
            guard let item = collectionView.item(at: indexPath) else {continue}
            (item as! TimelineGridCollectionViewItem).removeHighlight()
        }
    }
    
}
