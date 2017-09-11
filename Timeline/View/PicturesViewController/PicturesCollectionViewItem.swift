//
//  PicturesCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/8/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PicturesCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var pictureImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureImageView.imageScaling = .scaleProportionallyUpOrDown
    }
}
