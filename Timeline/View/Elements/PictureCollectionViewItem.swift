//
//  PictureCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var pictureImageView: NSImageView?
    
    weak var picture: Picture?
    var onClick: ((Picture, NSEvent)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureImageView?.imageScaling = .scaleProportionallyUpOrDown
    }
    
    func load(picture: Picture) {
        self.picture = picture
        
        let sized = picture.image(sizeTo: pictureImageView!.frame.size)
        
        let cgImage = picture.image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        let new = NSImage(cgImage: cgImage!, size: sized.size)
        pictureImageView?.image = new
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        if let onClick = onClick, let picture = picture {
            onClick(picture, event)
        }
       
    }
    
}
