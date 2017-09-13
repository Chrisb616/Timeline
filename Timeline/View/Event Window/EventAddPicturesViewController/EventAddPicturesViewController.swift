//
//  EventAddPicturesViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/12/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class EventAddPicturesViewController: NSViewController {
    
    @IBOutlet weak var currentPicturesCollectionView: NSCollectionView!
    @IBOutlet weak var currentPicturesCollectionViewFlowLayout: NSCollectionViewFlowLayout!
    
    @IBOutlet weak var unusedPicturesCollectionView: NSCollectionView!
    @IBOutlet weak var unusedPicturesCollectionViewFlowLayout: NSCollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
