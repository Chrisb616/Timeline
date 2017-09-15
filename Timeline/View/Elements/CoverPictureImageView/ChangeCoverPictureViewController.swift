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
    weak var subject: HasCoverPicture?
    
    static func instanceFromNib(withPictures pictures: [Picture], subject: HasCoverPicture?) -> ChangeCoverPictureViewController {
        let vc = ChangeCoverPictureViewController(nibName: NSNib.Name("ChangeCoverPictureViewController"), bundle: nil)
        vc.subject = subject
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
            //print("\(self.subject)")
        }
        
        pictureCollectionView.loadPictures(pictures)
    }
    
    
    
}
