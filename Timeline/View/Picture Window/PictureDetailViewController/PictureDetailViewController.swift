//
//  PictureDetailViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/11/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class PictureDetailViewController: NSViewController {
    
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var dateLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    
    static func instanceFromNib(forPicture picture: Picture) -> PictureDetailViewController {
        let vc = PictureDetailViewController(nibName: NSNib.Name("PictureDetailViewController"), bundle: nil)
        vc.picture = picture
        return vc
    }
    
    var picture: Picture!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        setUpImageView()
    }
    
    func setUpImageView() {
        resizeImage()
        titleTextField.stringValue = picture.title
        dateLabel.stringValue = picture.date.formatted(as: "EEEE, MMMM d, y")
        timeLabel.stringValue = picture.date.formatted(as: "hh:mm:ssa")
    }
    
    func resizeImage() {
        imageView.image = picture.image(sizeTo: imageView.frame.size)
    }
    
}
