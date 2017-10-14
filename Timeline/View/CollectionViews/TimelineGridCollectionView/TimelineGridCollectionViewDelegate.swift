//
//  TimelineGridCollectionViewDelegate.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/25/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewDelegate: NSObject, NSCollectionViewDelegate {
    
    var isInternalDrag = false
    
    weak var customCollectionView: TimelineGridCollectionView?

    func collectionView(_ collectionView: NSCollectionView, canDragItemsAt indexes: IndexSet, with event: NSEvent) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt index: Int) -> NSPasteboardWriting? {
        guard let event = (collectionView.item(at: index) as? TimelineGridCollectionViewItem)?.event else {
            Debugger.log(string: "Could not find timelineItem in collection view item during drag and drop", logType: .failure, logLevel: .minimal)
            return nil
        }
        
        return NSString(string: event.uniqueID)
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItemsAt indexes: IndexSet) {
        isInternalDrag = true
    }
    
    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        if isInternalDrag {
            if proposedDropOperation.pointee == .before {
                proposedDropOperation.pointee = .on
            }
            return NSDragOperation.every
        } else {
            return NSDragOperation.copy
        }
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, dragOperation operation: NSDragOperation) {
        Debugger.log(string: "Ended Dragging Session", logType: .process, logLevel: .verbose)
    }
    
    func collectionView(collectionView: NSCollectionView, draggingSession session: NSDraggingSession, endedAtPoint screenPoint: NSPoint, dragOperation operation: NSDragOperation) {
        isInternalDrag = false
    }
    
    func collectionView(_ collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, indexPath: IndexPath, dropOperation: NSCollectionView.DropOperation) -> Bool {
        
        //Iterate over Items dragged in
        draggingInfo.enumerateDraggingItems(options: .clearNonenumeratedImages, for: collectionView, classes: [NSString.self, NSURL.self], searchOptions: [:]) { (item, index, stop) in
            
            if let url = item.item as? URL {
                ImageManager.instance.importImage(from: url, completion: { (nsImage) in
                    
                    if let nsImage = nsImage {
                        let image = Image(image: nsImage, fromURL: url)
                        let event = Event.new(withMomentDate: Date(), image: image)
                        event.mainImage = image
                        self.customCollectionView?.timeline.events.add(event)
                    }
                    
                })
            }
            
            if let from = item.item as? String, let to = (collectionView.item(at: indexPath.item) as? TimelineGridCollectionViewItem)?.event.uniqueID {
                
                NotificationManager.instance.postMergeEventNotification(mergeEventWithUniqueID: from, intoEventWithUniqueID: to)
            }
        }
        
        NotificationManager.instance.postMainTimelineUpdateNotification()
        return true
    }
}
