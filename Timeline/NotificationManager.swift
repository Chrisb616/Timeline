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
    
    private let mainTimelineUpdateObserverName = NSNotification.Name("MainTimelineUpdate")
    
    func addMainTimelineUpdateObserver(observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: mainTimelineUpdateObserverName, object: nil)
    }
    
    func postMainTimelineUpdateNotification() {
        NotificationCenter.default.post(name: mainTimelineUpdateObserverName, object: nil)
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
