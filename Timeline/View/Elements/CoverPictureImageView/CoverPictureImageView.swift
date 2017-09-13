//
//  CoverPictureImageView.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class CoverPictureImageView: NSImageView {
    
    private weak var presentingViewController: NSViewController?
    
    private var coverPictureUniqueID: UniqueID?
    private var allPicturesUniqueIDs: [UniqueID]?
    
    func configure(coverPictureUniqueID: UniqueID, allPicturesUniqueIDs: [UniqueID], presentingViewController: NSViewController) {
        self.presentingViewController = presentingViewController
        self.coverPictureUniqueID = coverPictureUniqueID
        self.allPicturesUniqueIDs = allPicturesUniqueIDs
        
        self.image = DataStore.instance.retrievePicture(withUniqueID: coverPictureUniqueID)?.image
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        if event.clickCount > 1 {
            presentChangeCoverPictureViewController()
        }
    }
    
    private func presentChangeCoverPictureViewController() {
        let pictures = DataStore.instance.retrievePictures(withUniqueIDs: allPicturesUniqueIDs ?? [])
        
        let changeVC = ChangeCoverPictureViewController.instanceFromNib(withPictures: pictures)
        
        presentingViewController?.presentViewControllerAsSheet(changeVC)
    }
    
}
