//
//  ChangeCoverPictureViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class ChangeCoverPictureViewController: NSViewController {
    
    @IBOutlet weak var pictureCollectionView: PictureCollectionView!
    
    var pictures = [Picture]()
    
    static func instanceFromNib(withPictures pictures: [Picture]) -> ChangeCoverPictureViewController {
        let vc = ChangeCoverPictureViewController(nibName: NSNib.Name("ChangeCoverPictureViewController"), bundle: nil)
        vc.pictures = pictures
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        pictureCollectionView.configure()
        pictureCollectionView.overrideLayoutValues { (layout) in
            layout.overrideItemSize = NSSize(width: 100, height: 100)
        }
        pictureCollectionView.setOnClickAction { (picture, event) in
            print("WORKING")
        }
        
        pictureCollectionView.loadPictures(pictures)
    }
    
}
