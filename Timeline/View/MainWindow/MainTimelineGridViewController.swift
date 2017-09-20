//
//  MainTimelineGridViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/20/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class MainTimelineGridViewController: NSViewController {

    @IBOutlet weak var collectionView: TimelineGridCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.configure()
        collectionView.load(timelineItems: [Event.init(uniqueID: "Event", startDate: Date(), endDate: Date().addingTimeInterval(2))])
        collectionView.reloadData()
    }
    
}
