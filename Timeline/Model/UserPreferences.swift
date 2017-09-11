//
//  UserPreferences.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class UserPreferences {
    
    static var instance = UserPreferences()
    private init() {
        _directoryHome = userDefaults.url(forKey: directoryHomeKey) ?? URL(fileURLWithPath:NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    }
    
    //MARK: - Utililties
    private var userDefaults = UserDefaults.standard
    
    //MARK: - User Defaults Keys
    private var directoryHomeKey: String = "directoryHome"
    
    //MARK: - Properties
    private var _directoryHome: URL
    var directoryHome: URL { return _directoryHome.appendingPathComponent("Timeline") }
    
    //MARK: - Set Methods
    func setDirectoryHome(url: URL) {
        userDefaults.set(url, forKey: directoryHomeKey)
        _directoryHome = url
    }
    
}
