//
//  EventPicturesViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventPicturesViewController: NSViewController {
    
    weak var event: Event!
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var collectionViewFlowLayout: NSCollectionViewFlowLayout!
    
    static func instanceFromNib(forEvent event: Event) -> EventPicturesViewController {
        let vc = EventPicturesViewController(nibName: NSNib.Name("EventPicturesViewController"), bundle: nil)
        vc.event = event
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    private func configureCollectionView() {
        collectionViewFlowLayout.itemSize = NSSize(width: 100, height: 140)
        collectionViewFlowLayout.sectionInset = NSEdgeInsetsMake(10, 10, 10, 10)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        collectionView.wantsLayer = true
        
        collectionView.layer = CALayer()
        collectionView.layer?.backgroundColor = NSColor.white.cgColor
        
    }
    
}
