//
//  PicturesViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/8/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PicturesViewController: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var collectionViewFlowLayout: NSCollectionViewFlowLayout!
    
    var pictures = [Picture]()
    
    static var instanceFromNib: PicturesViewController {
        return PicturesViewController(nibName: NSNib.Name("PicturesViewController"), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        collectionView.dataSource = self
        update()
        NotificationManager.instance.addPictureUpdateObserver(observer: self, selector: #selector(update))
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionViewFlowLayout.itemSize = NSSize(width: 200, height: 200)
        collectionViewFlowLayout.sectionInset = NSEdgeInsetsMake(10, 10, 10, 10)
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.minimumInteritemSpacing = 5
        collectionViewFlowLayout.headerReferenceSize = NSSize(width: 20, height: 20)
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        collectionView.wantsLayer = true
        
        collectionView.layer = CALayer()
        collectionView.layer?.backgroundColor = NSColor.white.cgColor
    }
}

extension PicturesViewController: NSCollectionViewDataSource {
    
    @objc func update() {
        Debugger.log(string: "Updating pictures collection view", logType: .process, logLevel: .verbose)
        pictures = DataStore.instance.pictures.chronological
        collectionView?.reloadData()
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataStore.instance.pictures.count
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PicturesCollectionViewItem"), for: indexPath)
        
        guard let collectionViewItem = item as? PicturesCollectionViewItem else {
            return item
        }
        
        let picture = pictures[indexPath.item]
        
        collectionViewItem.load(picture: picture)
        
        return collectionViewItem
    }
    
}
