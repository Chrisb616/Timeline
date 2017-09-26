//
//  TimelineGridCollectionView.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/23/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionView: NSCollectionView {
    
    var customLayout: TimelineGridCollectionViewFlowLayout!
    var customDataSource: TimelineGridCollectionViewDataSource!
    var customDelegate: TimelineGridCollectionViewDelegate!
    
    func configure() {
        
        self.isSelectable = true
        self.allowsMultipleSelection = true
        
        configureDragAndDrop()
        configureDelegate()
        configureFlowLayout()
        configureDataSource()
    }
    
    private func configureDragAndDrop() {
        let urlType = NSPasteboard.PasteboardType(rawValue: kUTTypeFileURL as String)
        self.registerForDraggedTypes([.string, urlType])
        self.setDraggingSourceOperationMask(.every, forLocal: true)
        self.setDraggingSourceOperationMask(.every, forLocal: false)
    }
    
    private func configureDelegate() {
        self.customDelegate = TimelineGridCollectionViewDelegate()
        
        delegate = customDelegate
    }
    
    private func configureFlowLayout() {
        customLayout = TimelineGridCollectionViewFlowLayout()
        customLayout.configure()
        collectionViewLayout = customLayout
        
    }
    private func configureDataSource() {
        customDataSource = TimelineGridCollectionViewDataSource()
        dataSource = customDataSource
    }
    
    func reload(timelineItems: [TimelineItem]) {
        self.customDataSource.timelineItems = timelineItems
        reloadData()
    }
    
}
