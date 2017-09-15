//
//  PictureCollectionViewDelegate.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/15/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionViewDelegate: NSObject, NSCollectionViewDelegate {
    
    //MARK: - Drag and Drop
    
    func collectionView(_ collectionView: NSCollectionView, canDragItemsAt indexes: IndexSet, with event: NSEvent) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        guard let picture = (collectionView.item(at: indexPath) as? PictureCollectionViewItem)?.picture else {
            Debugger.log(string: "Could not find picture in collection view item during drag and drop", logType: .failure, logLevel: .minimal)
            return nil
        }
        
        return picture.image
    }
    
    //MARK: - Selection
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let pictureCollectionView = collectionView as! PictureCollectionView
        
        pictureCollectionView.highlightItems(selected: true, atIndexPaths: indexPaths)
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        let pictureCollectionView = collectionView as! PictureCollectionView
        
        pictureCollectionView.highlightItems(selected: false, atIndexPaths: indexPaths)
    }
    
}
