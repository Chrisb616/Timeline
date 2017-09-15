//
//  PictureCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var pictureImageView: NSImageView!
    
    var imageHighlightLayer: CALayer!
    
    weak var picture: Picture?
    var onClick: ((Picture, NSEvent)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageHighlightLayer = CALayer()
        
        pictureImageView?.imageScaling = .scaleProportionallyUpOrDown
        pictureImageView.wantsLayer = true
        
        imageHighlightLayer.borderWidth = 0.0
        imageHighlightLayer.borderColor = NSColor(calibratedRed: 0.0, green: 0.5, blue: 1.0, alpha: 1.0).cgColor
    }
    
    func load(picture: Picture) {
        self.picture = picture
        
        let sized = picture.image(sizeTo: pictureImageView!.frame.size)
        
        let cgImage = picture.image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        let new = NSImage(cgImage: cgImage!, size: sized.size)
        pictureImageView?.image = new
        
        pictureImageView.layer?.addSublayer(imageHighlightLayer)
        imageHighlightLayer.frame.size = sized.size
        centerHighlightLayer()
    }
    
    func centerHighlightLayer() {
        let x = (pictureImageView.frame.width / 2) - (imageHighlightLayer.frame.width / 2)
        let y = (pictureImageView.frame.height / 2) - (imageHighlightLayer.frame.height / 2)
        
        imageHighlightLayer.frame.origin = CGPoint(x: x, y: y)
    }
    /*
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        if let onClick = onClick, let picture = picture {
            onClick(picture, event)
        }
       
    }
 */
    
    func setHighlight(selected: Bool) {
        imageHighlightLayer.borderWidth = selected ? 5.0 : 0.0
    }
    
}
