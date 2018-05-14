//
//  MomentDetailViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 10/17/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class MomentDetailViewController: NSViewController {
    
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var narrativeTextView: NSTextView!
    
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func loadMoment(_ moment: Moment) {
        imageView.image = moment.image.valueOrDefault
        nameTextField.stringValue = moment.name
        narrativeTextView.string = moment.narrative ?? ""
    }
    
}
