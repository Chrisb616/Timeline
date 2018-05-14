//
//  AppDelegate.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Debugger.log(string: "Application Finished Launching", logType: .process, logLevel: .full)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        Debugger.log(string: "Application Will Terminate", logType: .process, logLevel: .full)
    }


}

