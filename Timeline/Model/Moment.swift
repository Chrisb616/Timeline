//
//  Moment.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Cocoa

class Moment: HasUniqueID {
    
    //MARK: - UniqueID
    
    var uniqueID: UniqueID
    
    //MARK: - Name
    
    private var _name: String?
    var name: String { return _name ?? date.formatted(as: "MMMM dd, yyyy")}
    
    var narrative: String?
    
    var date: Date
    
    var image: Image
    
    weak var parentEvent: Event!
    
    init(uniqueID: UniqueID, name: String?, narrative: String?, date: Date, image: Image, parentEvent: Event) {
        self.uniqueID = uniqueID
        self._name = name
        self.narrative = narrative
        self.date = date
        self.image = image
        self.parentEvent = parentEvent
    }
    
    /*
    
    //MARK: - Properties
    //MARK: -
    
    //MARK: - UniqueID
    
    var uniqueID: UniqueID
    
    //MARK: - Name
    private var _name: String?
    var name: String { return _name ?? timelineDate.formatted(as: "MMMM dd, yyyy")}
    
    //MARK: - Date
    var timelineDate: Date { return date }
    var date: Date
    
    //MARK: - Image
    var image: Image
    
    //MARK: -
    weak var parentEvent: Event?
    weak var parentOccurance: Occurance?
    
    var narrative: String?
    
    static func new(date: Date) -> Moment {
        let uniqueID = UniqueIDGenerator.instance.timelineItem
        
        return Moment(uniqueID: uniqueID, date: date)
    }
    
    static func new(fromImageWithURL url: URL) -> Moment {
        let moment = Moment.new(date: Date())
        moment.image = Image(imageURL: url)
        return moment
    }
    
    init(uniqueID: UniqueID, date: Date) {
        self.date = date
        self.uniqueID = uniqueID
        self.image = Image()
    }
    
    func setName(_ name: String?) {
        self._name = name
    }
    
    func setImage(withURL url: URL) {
        self.image.imageURL = url
    }
    
    func setParent
 */
}
