//
//  PicturesViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/8/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PicturesViewController: NSViewController {
    
    @IBOutlet weak var collectionView: PictureCollectionView!
        
    static var instanceFromNib: PicturesViewController {
        return PicturesViewController(nibName: NSNib.Name("PicturesViewController"), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.configure()
        collectionView.setOnClickAction { (picture, event) in
            if event.clickCount > 1 {
                let pictureWindowController = PictureWindowController.loadfor(picture: picture)
                MainWindowController.instance.pictureWindowController = pictureWindowController
                pictureWindowController.showWindow(nil)
            }
        }
        update()
        
        NotificationManager.instance.addPictureUpdateObserver(observer: self, selector: #selector(update))
        
    }
    
    @objc func update() {
        Debugger.log(string: "Updating pictures collection view", logType: .process, logLevel: .verbose)
        collectionView.loadPictures(DataStore.instance.pictures.chronological)
    }
}

