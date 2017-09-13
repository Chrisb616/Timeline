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
    
    weak var picture: Picture!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        setUpImageView()
        
        NotificationManager.instance.addPictureUpdateObserver(observer: self, selector: #selector(setUpImageView))
    }
    
    @objc func setUpImageView() {
        if picture != nil {
            resizeImage()
            titleTextField.stringValue = picture.title
            
            if let date = picture.date {
                dateLabel.stringValue = date.formatted(as: "EEEE, MMMM d, y")
                timeLabel.stringValue = date.formatted(as: "hh:mm:ssa")
            } else {
                dateLabel.stringValue = ""
                timeLabel.stringValue = ""
            }
        }
    }
    
    func resizeImage() {
        imageView?.image = picture?.image(sizeTo: imageView?.frame.size ?? CGSize())
    }
    
    func refreshImage() {
        picture.refreshImage()
    }
}
