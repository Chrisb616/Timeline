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
    
    weak var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureImageView.imageScaling = .scaleProportionallyUpOrDown
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        if event.clickCount > 1 {
            guard let picture = self.picture else {
                Debugger.log(string: "No picture found for collection view item", logType: .warning, logLevel: .full)
                return
            }
            let pictureWindowController = PictureWindowController.loadfor(picture: picture)
            MainWindowController.instance.pictureWindowController = pictureWindowController
            pictureWindowController.showWindow(nil)
        }
    }
}
