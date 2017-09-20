//
//  Moment.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/15/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Moment: TimelineItem {
    
    //MARK: - Properties
    //MARK: -
    
    //MARK: - UniqueID
    
    var uniqueID: UniqueID
    
    //MARK: - Date
    var date: Date
    
    var pictureID: UniqueID?
    
    //MARK: - Strings
    private var _name: String?
    var name: String { return _name ?? date.formatted(as: "MMMM dd, yyyy")}
    
    var narrative: String?
    
    //MARK: - Initialization
    init(uniqueID: UniqueID, date: Date) {
        self.date = date
        self.uniqueID = uniqueID
    }
    
    //MARK: - Methods
    //MARK: -
    
    //MARK: - Private variable accessors
    func setName(_ name: String?) {
        self._name = name
    }
    
    func clearName() {
        self._name = nil
    }
    
}

