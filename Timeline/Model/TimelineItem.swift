//
//  TimelineItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/15/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

protocol TimelineItem: class, HasUniqueID {
    
    var name: String { get }
    var narrative: String? { get set }
    var date: Date { get set }
    var pictureID: UniqueID? { get set }
    
    
    func setName(_ name: String?)
    
    //TODO: - Add in capabilities for the main picture (pictureID, picture properties) to be cropped without storing the image data. Each timeline item should contain this crop information for the image. Can be automatic cropping but eventually should allow for customized cropping.
}

extension TimelineItem {
    
    var picture: Picture? {
        if let pictureID = pictureID {
            return DataStore.instance.retrievePicture(withUniqueID: pictureID)
        } else {
            return nil
        }
    }
    
}
