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
        
        NotificationManager.instance.addShowMomentDetailObserver(observer: self, selector: #selector(showMomentDetail(_:)))
    }
    
    func loadMoment(_ moment: Moment) {
        imageView.image = moment.image.valueOrDefault
        nameTextField.stringValue = moment.name
        narrativeTextView.string = moment.narrative ?? ""
    }
    
    @objc func showMomentDetail(_ notification: Notification) {
        guard let uniqueID = notification.userInfo?["momentUniqueID"] as? UniqueID else {
            Debugger.log(string: "No moment  unique ID in notification info", logType: .failure, logLevel: .minimal)
            return
        }
        
        guard let moment = Timeline.main.moments.with(uniqueID: uniqueID) else {
            Debugger.log(string: "No moment with uniqueID \(uniqueID)", logType: .failure, logLevel: .minimal)
            return
        }
        
        loadMoment(moment)
    }
    
}
