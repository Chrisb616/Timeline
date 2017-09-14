//
//  HasCoverPicture.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

protocol HasCoverPicture: class {
    
    var coverPictureUniqueID: UniqueID? { get set }
    
    var pictureUniqueIDs: [UniqueID: Bool] { get set }
    
}

extension HasCoverPicture {
    
    var coverPicture: Picture? {
        if let uniqueID = coverPictureUniqueID {
            return DataStore.instance.retrievePicture(withUniqueID: uniqueID)
        } else {
            return nil
        }
    }
    
    var pictures: [Picture] {
        return DataStore.instance.retrievePictures(withUniqueIDs: pictureUniqueIDs.keysArray)
    }
    
}
