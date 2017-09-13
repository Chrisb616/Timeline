//
//  PictureCollectionViewFlowLayout.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionViewFlowLayout: NSCollectionViewFlowLayout {
    
    var overrideItemSize: NSSize?
    var overrideSectionInset: NSEdgeInsets?
    var overrideMinimumLineSpacing: CGFloat?
    var overrideMinimumInteritemSpacing: CGFloat?
    var overrideHeaderReferenceSize: NSSize?
    
    func configure() {
        self.itemSize = overrideItemSize ?? NSSize(width: 200, height: 200)
        self.sectionInset = overrideSectionInset ?? NSEdgeInsetsMake(10, 10, 10, 10)
        self.minimumLineSpacing = overrideMinimumLineSpacing ?? 10
        self.minimumInteritemSpacing = overrideMinimumInteritemSpacing ?? 5
        self.headerReferenceSize = overrideHeaderReferenceSize ?? NSSize(width: 20, height: 20)
    }
    
}
