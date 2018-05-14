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
    private let showMomentDetailName = NSNotification.Name("ShowMomentDetail")
    private let mergeEventName = NSNotification.Name("MergeEvent")
    
    private func mainRootTabSwitchName(forTab tab: MainRootTabViewController.Tab) -> NSNotification.Name {
        return NSNotification.Name("MainRootTabViewSwitch to \(tab)")
    }
    
    //MARK: - Main Root Tabs
    
    func addMainRootTabViewSwitchObserver(forTab tab: MainRootTabViewController.Tab, observer: Any, selector: Selector) {
        Debugger.log(string: "Adding tab view switch observer. Will trigger \(observer) method \(selector) for \(tab)", logType: .process, logLevel: .full)
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: mainRootTabSwitchName(forTab: tab), object: nil)
    }
    
    func postMainRootTabViewSwitchNotification(forTab tab: MainRootTabViewController.Tab) {
        Debugger.log(string: "Posting tab view switch notification for tab \(tab)", logType: .process, logLevel: .full)
        
        NotificationCenter.default.post(name: mainRootTabSwitchName(forTab: tab), object: nil)
    }
    
    //MARK: - Timeline Grid
    
    func addMainTimelineUpdateObserver(observer: Any, selector: Selector) {
        Debugger.log(string: "Adding main timeline update observer. Will trigger \(observer) method \(selector).", logType: .process, logLevel: .full)
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: mainTimelineUpdateName, object: nil)
    }
    
    func postMainTimelineUpdateNotification() {
        Debugger.log(string: "Posting main timeline update notification.", logType: .process, logLevel: .full)
        
        NotificationCenter.default.post(name: mainTimelineUpdateName, object: nil)
    }
    
    func addMergeEventObserver(observer: Any, selector: Selector) {
        Debugger.log(string: "Adding merge event observer. Will trigger \(observer) method \(selector).", logType: .process, logLevel: .full)
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: mergeEventName, object: nil)
    }
    
    func postMergeEventNotification(mergeEventWithUniqueID fromUniqueID: UniqueID, intoEventWithUniqueID toUniqueID: UniqueID) {
        Debugger.log(string: "Posting merge event notification. Merging event with ID \(fromUniqueID) to event with ID \(toUniqueID).", logType: .process, logLevel: .full)
        
        NotificationCenter.default.post(name: mergeEventName, object: nil, userInfo: ["from":fromUniqueID,"to":toUniqueID])
    }
    
    func addShowEventDetailObserver(observer: Any, selector: Selector) {
        Debugger.log(string: "Adding show event detail observer. Will trigger \(observer) method \(selector).", logType: .process, logLevel: .full)
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: showEventDetailName, object: nil)
    }
    
    func postShowEventDetailNotification(forEventWithUniqueID uniqueID: UniqueID) {
        Debugger.log(string: "Posting show event detail notification for event with ID \(uniqueID).", logType: .process, logLevel: .full)
        
        NotificationCenter.default.post(name: showEventDetailName, object: nil, userInfo: ["eventUniqueID":uniqueID])
    }
    
    func addShowMomentDetailObserver(observer: Any, selector: Selector) {
        Debugger.log(string: "Adding show moment detail observer. Will trigger \(observer) method \(selector).", logType: .process, logLevel: .full)
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: showMomentDetailName, object: nil)
    }
    
    func postShowMomentDetailNotification(forMomentWithUniqueID uniqueID: UniqueID) {
        Debugger.log(string: "Posting show moment detail notification for moment with ID \(uniqueID).", logType: .process, logLevel: .full)
        
        NotificationCenter.default.post(name: showMomentDetailName, object: nil, userInfo: ["momentUniqueID":uniqueID])
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
    
}
