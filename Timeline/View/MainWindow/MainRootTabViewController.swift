//
//  MainRootTabViewController.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/25/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class MainRootTabViewController: NSTabViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedTabViewItemIndex = 1
        self.selectedTabViewItemIndex = 0
        
        NotificationManager.instance.addMainRootTabViewSwitchObserver(forTab: .mainTimleineGrid, observer: self, selector: #selector(showMainTimelineGrid(_:)))
        NotificationManager.instance.addShowEventDetailObserver(observer: self, selector: #selector(showEventDetailTab(_:)))
    }
    
    @objc func showMainTimelineGrid(_ notification: Notification) {
        self.selectedTabViewItemIndex = 0
    }
    @objc func showEventDetailTab(_ notification: Notification) {
        self.selectedTabViewItemIndex = 1
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
