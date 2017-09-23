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
    
    func configure() {
        
        self.isSelectable = true
        self.allowsMultipleSelection = true
        
        //self.layer?.backgroundColor = NSColor.black.cgColor
        
        
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
    
}
