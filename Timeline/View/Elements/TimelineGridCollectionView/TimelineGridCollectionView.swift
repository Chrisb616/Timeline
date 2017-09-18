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
    private var _delegate: TimelineGridCollectionViewDelegate?
    
    func configure() {
        configureCollectionView()
        configureLayout()
        configureDelegate()
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
    
    func configureDelegate() {
        self._delegate = TimelineGridCollectionViewDelegate()
        self.delegate = self._delegate
    }
    
    func load(timelineItems: [TimelineItem]) {
        self._dataSource?.load(timelineItems: timelineItems)
        self.reloadData()
    }
    
}
