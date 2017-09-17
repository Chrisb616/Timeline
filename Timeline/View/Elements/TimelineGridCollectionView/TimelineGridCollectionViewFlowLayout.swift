//
//  TimelineGridCollectionViewFlowLayout.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/17/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewFlowLayout: NSCollectionViewFlowLayout {
    
    var overrideItemSize: NSSize?
    var overrideSectionInset: NSEdgeInsets?
    var overrideMinimumLineSpacing: CGFloat?
    var overrideMinimumInteritemSpacing: CGFloat?
    var overrideHeaderReferenceSize: NSSize?
    
    private var standardItemSize: NSSize = NSSize(width: 150, height: 200)
    private var standardSectionInset: NSEdgeInsets = NSEdgeInsetsMake(10, 10, 10, 10)
    private var standardMinimumLineSpacing: CGFloat = 10
    private var standardMinimumInteritemSpacing: CGFloat = 5
    private var standardHeaderReferenceSize: NSSize = NSSize(width: 20, height: 20)
    
    func configure() {
        self.itemSize = overrideItemSize ?? standardItemSize
        self.sectionInset = overrideSectionInset ?? standardSectionInset
        self.minimumLineSpacing = overrideMinimumLineSpacing ?? standardMinimumLineSpacing
        self.minimumInteritemSpacing = overrideMinimumInteritemSpacing ?? standardMinimumInteritemSpacing
        self.headerReferenceSize = overrideHeaderReferenceSize ?? standardHeaderReferenceSize
    }
    
}
