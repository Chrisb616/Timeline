//
//  TimelineGridCollectionViewDelegate.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/25/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewDelegate: NSObject, NSCollectionViewDelegate {
    
    var itemsBeingDragged = [Int]()

    func collectionView(_ collectionView: NSCollectionView, canDragItemsAt indexes: IndexSet, with event: NSEvent) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt index: Int) -> NSPasteboardWriting? {
        guard let timelineItem = (collectionView.item(at: index) as? TimelineGridCollectionViewItem)?.timelineItem else {
            Debugger.log(string: "Could not find timelineItem in collection view item during drag and drop", logType: .failure, logLevel: .minimal)
            return nil
        }
        
        //return timelineItem
        //return NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.desktopDirectory, .allDomainsMask, true)[0])
        return NSString(string: timelineItem.uniqueID)
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItemsAt indexes: IndexSet) {
        indexes.forEach {
            self.itemsBeingDragged.append($0)
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        if proposedDropOperation.pointee == .before {
            proposedDropOperation.pointee = .on
        }
        return NSDragOperation.every
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, dragOperation operation: NSDragOperation) {
        print("ended")
    }
    
    func collectionView(collectionView: NSCollectionView, draggingSession session: NSDraggingSession, endedAtPoint screenPoint: NSPoint, dragOperation operation: NSDragOperation) {
        itemsBeingDragged = []
    }
    
    func collectionView(_ collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, indexPath: IndexPath, dropOperation: NSCollectionView.DropOperation) -> Bool {
        
        draggingInfo.enumerateDraggingItems(options: .clearNonenumeratedImages, for: collectionView, classes: [NSString.self], searchOptions: [:]) { (item, index, stop) in
            
            if let from = item.item as? String, let to = (collectionView.item(at: indexPath.item) as? TimelineGridCollectionViewItem)?.timelineItem.uniqueID {
                
                NotificationManager.instance.postMergeEventNotification(mergeEventWithUniqueID: from, intoEventWithUniqueID: to)
            }
        }
        
        return true
    }
}
