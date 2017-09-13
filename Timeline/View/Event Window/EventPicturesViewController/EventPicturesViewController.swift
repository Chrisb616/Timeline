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
    var pictureIDs = [UniqueID]()
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var collectionViewFlowLayout: NSCollectionViewFlowLayout!
    
    static func instanceFromNib(forEvent event: Event) -> EventPicturesViewController {
        let vc = EventPicturesViewController(nibName: NSNib.Name("EventPicturesViewController"), bundle: nil)
        vc.event = event
        vc.pictureIDs = event.pictures.map{ $0.key }
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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

extension EventPicturesViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return event.pictures.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PictureCollectionViewItem"), for: indexPath)
        
        guard let collectionViewItem = item as? PictureCollectionViewItem else {
            return item
        }
        
        let pictureID = pictureIDs[indexPath.item]
        
        guard let picture = DataStore.instance.retrievePicture(withUniqueID: pictureID) else { return item }
        
        collectionViewItem.load(picture: picture)
        
        return collectionViewItem
    }
    
}
