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
    private var customDataSource: TimelineGridCollectionViewDataSource!
    
    func configure() {
        
        self.isSelectable = true
        self.allowsMultipleSelection = true
        
        configureFlowLayout()
        configureDataSource()
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
