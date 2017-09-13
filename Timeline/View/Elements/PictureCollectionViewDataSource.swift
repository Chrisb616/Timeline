//
//  PictureCollectionViewDataSource.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionViewDataSource: NSObject, NSCollectionViewDataSource {
    
    var pictures = [Picture]()
    var onClick: ((Picture, NSEvent)->Void)?
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PictureCollectionViewItem"), for: indexPath)
        
        guard let collectionViewItem = item as? PictureCollectionViewItem else {
            return item
        }
        
        let picture = pictures[indexPath.item]
        
        collectionViewItem.load(picture: picture)
        collectionViewItem.onClick = onClick
        
        return collectionViewItem
    }
    
}
