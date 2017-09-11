//
//  Debugger.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/10/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Debugger {
    
    private static let instance = Debugger()
    private init() {}
    
    var logLevel: LogLevel = .verbose
    
    static func setLogLevel(_ logLevel: LogLevel) {
        Debugger.instance.logLevel = logLevel
    }
    
    static func log(string: String, logType: LogType, logLevel: LogLevel) {
        if logLevel == .none { return }
        
        if Debugger.instance.logLevel.rawValue >= logLevel.rawValue {
            print(logType.prefix + string + " \(Date().formatted(as: "HH:mm:ss"))")
        }
    }
    
    static func log(error: Error) {
        print("ERROR: \(error)")
    }
    
    enum LogType {
        case failure
        case warning
        case success
        case process
        
        var prefix: String {
            switch self {
            case .failure: return "FAILURE: "
            case .warning: return "WARNING: "
            case .success: return "SUCCESS: "
            case .process: return "PROCESS: "
            }
        }
    }
    
    enum LogLevel: Int {
        case none = 0
        case minimal
        case full
        case verbose
    }
    
}
