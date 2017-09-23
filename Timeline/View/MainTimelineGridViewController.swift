//
//  MainTimelineGridViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/23/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class MainTimelineGridViewController: NSViewController {
    
    @IBOutlet weak var collectionView: TimelineGridCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.configure()
    }
    
}
