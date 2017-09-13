//
//  PictureCollectionView.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionView: NSCollectionView {
    
    //MARK: - Properties
    private var pictureCollectionViewDataSource: PictureCollectionViewDataSource?
    private var pictureCollectionViewFlowLayout: PictureCollectionViewFlowLayout?
    
    //MARK: - Input Methods
    func loadPictures(_ pictures: [Picture]) {
        self.pictureCollectionViewDataSource?.pictures = pictures
        self.reloadData()
    }
    
    func setOnClickAction(_ action: @escaping (Picture, NSEvent) -> Void) {
        self.pictureCollectionViewDataSource?.onClick = action
    }
    
    //MARK: - Configure Methods
    func configure() {
        configureFlowLayout()
        configureLayer()
        configureDataSource()
    }
    
    private func configureLayer() {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    func overrideLayoutValues(_ configure: (PictureCollectionViewFlowLayout)->Void) {
        if let layout = pictureCollectionViewFlowLayout {
            configure(layout)
            layout.configure()
            reloadData()
        }
    }
    
    private func configureFlowLayout() {
        pictureCollectionViewFlowLayout = PictureCollectionViewFlowLayout()
        
        pictureCollectionViewFlowLayout?.configure()
        
        self.collectionViewLayout = pictureCollectionViewFlowLayout
    }
    
    private func configureDataSource() {
        self.pictureCollectionViewDataSource = PictureCollectionViewDataSource()
        self.dataSource = self.pictureCollectionViewDataSource
    }
    
}
