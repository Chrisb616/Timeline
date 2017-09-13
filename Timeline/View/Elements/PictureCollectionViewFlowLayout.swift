//
//  PictureCollectionViewFlowLayout.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionViewFlowLayout: NSCollectionViewFlowLayout {
    
    func configure() {
        self.itemSize = NSSize(width: 200, height: 200)
        self.sectionInset = NSEdgeInsetsMake(10, 10, 10, 10)
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 5
        self.headerReferenceSize = NSSize(width: 20, height: 20)
    }
    
}
