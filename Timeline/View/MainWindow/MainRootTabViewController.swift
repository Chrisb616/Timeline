//
//  MainRootTabViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/25/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class MainRootTabViewController: NSTabViewController {
    
    weak var eventDetailViewController: EventDetailViewController!
    
    override func viewDidLoad() {
        Debugger.log(string: "MainRootTabViewController finished load", logType: .process, logLevel: .full)
        
        super.viewDidLoad()
        
        self.selectedTabViewItemIndex = 2
        self.selectedTabViewItemIndex = 1
        self.selectedTabViewItemIndex = 0
        
        NotificationManager.instance.addMainRootTabViewSwitchObserver(forTab: .mainTimleineGrid, observer: self, selector: #selector(showMainTimelineGrid(_:)))
        NotificationManager.instance.addMainRootTabViewSwitchObserver(forTab: .eventDetail, observer: self, selector: #selector(showEventDetailTab(_:)))
        NotificationManager.instance.addShowEventDetailObserver(observer: self, selector: #selector(showEventDetailTab(_:)))
        NotificationManager.instance.addShowMomentDetailObserver(observer: self, selector: #selector(showMomentDetailTab(_:)))
    }
    
    func configureViewControllers() {
        Debugger.log(string: "Event Detail View Controller configuring tabs", logType: .process, logLevel: .full)
        
        if let eventDetailViewController = tabView.tabViewItem(at: 1).viewController as? EventDetailViewController {
            self.eventDetailViewController = eventDetailViewController
        }
    }
    
    @objc func showMainTimelineGrid(_ notification: Notification) {
        self.selectedTabViewItemIndex = 0
    }
    @objc func showEventDetailTab(_ notification: Notification) {
        self.selectedTabViewItemIndex = 1
    }
    @objc func showMomentDetailTab(_ notification: Notification) {
        self.selectedTabViewItemIndex = 2
    }
    
}

extension MainRootTabViewController {
    
    enum Tab: CustomStringConvertible {
        case mainTimleineGrid
        case eventDetail
        
        var index: Int {
            switch self {
            case .mainTimleineGrid: return 0
            case .eventDetail: return 1
            }
        }
        
        var description: String {
            switch self{
            case .mainTimleineGrid: return "MainTimelineGridTab"
            case .eventDetail: return "EventDetailTab"
            }
        }
    }
    
}
