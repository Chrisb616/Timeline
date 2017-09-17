//
//  TimelineGridCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/17/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class TimelineGridCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var pictureImageView: NSImageView!
    @IBOutlet weak var nameTextView: NSTextField!
    
    var imageHighlightLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePictureImageView()
        configureImageHighlightLayer()
    }
    
    private func configurePictureImageView() {
        self.pictureImageView.wantsLayer = true
        
        self.pictureImageView.layer?.cornerRadius = self.pictureImageView.frame.width * 0.10
    }
    
    private func configureImageHighlightLayer() {
        self.imageHighlightLayer = CALayer()
        
        self.pictureImageView.layer?.addSublayer(imageHighlightLayer)
        self.imageHighlightLayer.frame.size = pictureImageView.frame.size
        self.imageHighlightLayer.cornerRadius = self.pictureImageView.frame.width * 0.10
        
        self.imageHighlightLayer.borderWidth = 5
        self.imageHighlightLayer.borderColor = NSColor(calibratedRed: 250/255, green: 190/255, blue: 30/255, alpha: 1).cgColor
    }
}
