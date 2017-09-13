//
//  PictureCollectionView.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionView: NSCollectionView {
    
    private var pictureCollectionViewDataSource: PictureCollectionViewDataSource!
    
    func loadPictures(_ pictures: [Picture]) {
        self.pictureCollectionViewDataSource?.pictures = pictures
        self.reloadData()
    }
    
    func configure() {
        configureFlowLayout()
        configureLayer()
        configureDataSource()
    }
    
    private func configureLayer() {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    private func configureFlowLayout() {
        let flowLayout = PictureCollectionViewFlowLayout()
        
        flowLayout.configure()
        
        self.collectionViewLayout = flowLayout
        
    }
    
    private func configureDataSource() {
        self.pictureCollectionViewDataSource = PictureCollectionViewDataSource()
        self.dataSource = self.pictureCollectionViewDataSource
    }
    
}
