//
//  EventDetailCollectionView.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/25/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventDetailCollectionView: NSCollectionView {
    
    weak var event: Event!
    var customDataSource: EventDetailCollectionViewDataSource!
    var customLayout: EventDetailCollectionViewFlowLayout!
    var customDelegate: EventDetailCollectionViewDelegate!
    
    func configure(forEvent event: Event) {
        self.event = event
        
        configureDataSource()
        configureDelegate()
        configureFlowLayout()
        
    }
    
    func configureDataSource() {
        self.customDataSource = EventDetailCollectionViewDataSource()
        customDataSource.event = event
        
        self.dataSource = customDataSource
    }
    
    func configureDelegate() {
        self.customDelegate = EventDetailCollectionViewDelegate()
        
        self.delegate = customDelegate
    }
    
    func configureFlowLayout() {
        customLayout = EventDetailCollectionViewFlowLayout()
        customLayout.configure()
        self.collectionViewLayout = customLayout
    }
    
}
