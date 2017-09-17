//
//  MainViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/15/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var collectionView: TimelineGridCollectionView!
    
    
    static var instanceFromNib: MainViewController {
        return MainViewController(nibName: NSNib.Name("MainViewController"), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        collectionView.configure()
        collectionView.load(timelineItems: dummyData)
    }
    
    var dummyData: [TimelineItem] {
        let event = Event(uniqueID: "Testing", startDate: Date().addingTimeInterval(-10), endDate: Date())
        event.setName("Event")
        
        let moment = Moment(uniqueID: "Momentus", date: Date().addingTimeInterval(-99999999))
        
        return [event,moment]
    }
    
}
