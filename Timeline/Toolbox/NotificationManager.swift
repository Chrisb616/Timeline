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
    
    func addMainTimelineUpdateObserver(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: mainTimelineUpdateName, object: nil)
    }
    
    func postMainTimelineUpdateNotification() {
        NotificationCenter.default.post(name: mainTimelineUpdateName, object: nil)
    }
    
    func addMainRootTabViewSwitchObserver(forTab tab: MainRootTabViewController.Tab, observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: mainRootTabSwitchName(forTab: tab), object: nil)
    }
    
    func postMainRootTabViewSwitchNotification(forTab tab: MainRootTabViewController.Tab) {
        NotificationCenter.default.post(name: mainRootTabSwitchName(forTab: tab), object: nil)
    }
    
    func addShowEventDetailObserver(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: showEventDetailName, object: nil)
    }
    
    func postShowEventDetailNotification(forEventWithUniqueID uniqueID: UniqueID) {
        NotificationCenter.default.post(name: showEventDetailName, object: nil, userInfo: ["eventUniqueID":uniqueID])
    }
    
    func addMergeEventNotification(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: mergeEventName, object: nil)
    }
    
    func postMergeEventNotification(mergeEventWithUniqueID fromUniqueID: UniqueID, intoEventWithUniqueID toUniqueID: UniqueID) {
        NotificationCenter.default.post(name: mergeEventName, object: nil, userInfo: ["from":fromUniqueID,"to":toUniqueID])
    }
    
    /*
    
    let eventUpdateName = NSNotification.Name("EventUpdate")
    let pictureUpdateName = NSNotification.Name("PictureUpdate")
    
    func addEventUpdateObserver(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: eventUpdateName, object: nil)
        Debugger.log(string: "Adding \(eventUpdateName.rawValue) observer to \(observer) object", logType: .process, logLevel: .verbose)
    }
    
    func removeEventUpdateObserver(observer:Any) {
        NotificationCenter.default.removeObserver(observer, name: eventUpdateName, object: nil)
        Debugger.log(string: "Removing \(eventUpdateName.rawValue) observer from \(observer) object", logType: .process, logLevel: .verbose)
    }
    
    func postEventUpdateNotification() {
        NotificationCenter.default.post(name: eventUpdateName, object: nil)
        Debugger.log(string: "Posting notification for \(eventUpdateName.rawValue)", logType: .process, logLevel: .verbose)
    }
    
    func addPictureUpdateObserver(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: pictureUpdateName, object: nil)
        Debugger.log(string: "Adding \(pictureUpdateName.rawValue) observer to \(observer) object", logType: .process, logLevel: .verbose)
    }
    
    func removePictureUpdateObserver(observer:Any) {
        NotificationCenter.default.removeObserver(observer, name: pictureUpdateName, object: nil)
        Debugger.log(string: "Removing \(pictureUpdateName.rawValue) observer from \(observer) object", logType: .process, logLevel: .verbose)
    }
    
    func postPictureUpdateNotification() {
        NotificationCenter.default.post(name: pictureUpdateName, object: nil)
        Debugger.log(string: "Posting notification for \(pictureUpdateName.rawValue)", logType: .process, logLevel: .verbose)
    }
 */
}
