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
    
    @IBOutlet weak var collectionView: PictureCollectionView!
    
    static func instanceFromNib(forEvent event: Event) -> EventPicturesViewController {
        let vc = EventPicturesViewController(nibName: NSNib.Name("EventPicturesViewController"), bundle: nil)
        vc.event = event
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.configure()
        update()
        
    }

    func update() {
        let pictures = DataStore.instance.retrievePictures(withUniqueIDs: event.pictureUniqueIDs.keysArray)
        collectionView.loadPictures(pictures)
    }
    
    
    
}

