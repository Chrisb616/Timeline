//
//  PictureCollectionViewDelegate.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/15/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionViewDelegate: NSObject, NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let pictureCollectionView = collectionView as! PictureCollectionView
        
        pictureCollectionView.highlightItems(selected: true, atIndexPaths: indexPaths)
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        let pictureCollectionView = collectionView as! PictureCollectionView
        
        pictureCollectionView.highlightItems(selected: false, atIndexPaths: indexPaths)
    }
    
}
