//
//  PictureWindowController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/11/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureWindowController: NSWindowController {
    
    static func loadfor(picture: Picture) -> PictureWindowController {
        let windowController = PictureWindowController(windowNibName: NSNib.Name("PictureWindowController"))
        windowController.picture = picture
        windowController.window?.title = picture.title
        return windowController
    }
    
    var picture: Picture!
    
    var pictureDetailViewController: PictureDetailViewController!

    override func windowDidLoad() {
        super.windowDidLoad()
        
        setUpDetailViewController()
    }
    
    func setUpDetailViewController() {
        self.pictureDetailViewController = PictureDetailViewController.instanceFromNib(forPicture: picture)
        self.contentViewController = pictureDetailViewController
    }
    
}
