//
//  TimelineGridCollectionView.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/17/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionView: NSCollectionView {
    
    private var _collectionViewLayout: TimelineGridCollectionViewFlowLayout?
    private var _dataSource: TimelineGridCollectionViewDataSource?
    
    func configure() {
        configureCollectionView()
        configureLayout()
        configureDataSource()
    }
    
    func configureCollectionView() {
        self.allowsMultipleSelection = true
        self.isSelectable = true
    }
    
    func configureLayout() {
        self._collectionViewLayout = TimelineGridCollectionViewFlowLayout()
        self._collectionViewLayout?.configure()
        self.collectionViewLayout = _collectionViewLayout
    }
    
    func configureDataSource() {
        self._dataSource = TimelineGridCollectionViewDataSource()
        self.dataSource = _dataSource
    }
    
    func load(timelineItems: [TimelineItem]) {
        self._dataSource?.load(timelineItems: timelineItems)
        self.reloadData()
    }
    
}
