//
//  EventDetailCollectionViewItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 10/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventDetailCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var momentImageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func load(moment: Moment) {
        self.momentImageView.image = moment.image.valueOrDefault
    }
    
}
