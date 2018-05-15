//
//  SaveDataManager.swift
//  Timeline
//
//  Created by Christopher Boynton on 5/14/18.
//  Copyright © 2018 Self. All rights reserved.
//

import Foundation

class SaveDataManager {
    
    static var instance = SaveDataManager()
    private init() {}
    
    private var fileManager: FileManager { return FileManager.default }
    
    private var documentsDirectory: URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
   
    func saveTimelineInfo() {
        
        var saveDictionary = [String:Any]()
        
        saveDictionary.updateValue(Timeline.main.events.all.map{ $0.saveDictionary }, forKey: "events")
        
        dump(saveDictionary)
    }
    
}

