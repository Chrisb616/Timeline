//
//  NotificationManager.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class NotificationManager {
    
    private init() {}
    static let instance = NotificationManager()
    
    private let mainTimelineUpdateName = NSNotification.Name("MainTimelineUpdate")
    private let showEventDetailName = NSNotification.Name("ShowEventDetail")
    private let mergeEventName = NSNotification.Name("MergeEvent")
    
    private func mainRootTabSwitchName(forTab tab: MainRootTabViewController.Tab) -> NSNotification.Name {
        return NSNotification.Name("MainRootTabViewSwitch to \(tab)")
    }
    
    //MARK: - Main Root Tabs
    
    func addMainRootTabViewSwitchObserver(forTab tab: MainRootTabViewController.Tab, observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: mainRootTabSwitchName(forTab: tab), object: nil)
    }
    
    func postMainRootTabViewSwitchNotification(forTab tab: MainRootTabViewController.Tab) {
        NotificationCenter.default.post(name: mainRootTabSwitchName(forTab: tab), object: nil)
    }
    
    //MARK: - Timeline Grid
    
    func addMainTimelineUpdateObserver(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: mainTimelineUpdateName, object: nil)
    }
    
    func postMainTimelineUpdateNotification() {
        NotificationCenter.default.post(name: mainTimelineUpdateName, object: nil)
    }
    
    func addMergeEventNotification(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: mergeEventName, object: nil)
    }
    
    func postMergeEventNotification(mergeEventWithUniqueID fromUniqueID: UniqueID, intoEventWithUniqueID toUniqueID: UniqueID) {
        NotificationCenter.default.post(name: mergeEventName, object: nil, userInfo: ["from":fromUniqueID,"to":toUniqueID])
    }
    
    func addShowEventDetailObserver(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: showEventDetailName, object: nil)
    }
    
    func postShowEventDetailNotification(forEventWithUniqueID uniqueID: UniqueID) {
        NotificationCenter.default.post(name: showEventDetailName, object: nil, userInfo: ["eventUniqueID":uniqueID])
    }
    
    //MARK: - Event Detail
    
    private let toggleEditEventDetailsName = NSNotification.Name("ToggleEditEventDetails")
    private let eventWasEditedName = NSNotification.Name("EventWasEdited");
    
    func addToggleEditEventDetailsNotication(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: toggleEditEventDetailsName, object: nil)
    }
    
    func postToggleEditEventDetailsNotification() {
        NotificationCenter.default.post(name: toggleEditEventDetailsName, object: nil)
    }
    
    func addEventWasEditedNotication(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: eventWasEditedName, object: nil)
    }
    
    func postEventWasEditedNotification() {
        NotificationCenter.default.post(name: eventWasEditedName, object: nil)
    }
}
