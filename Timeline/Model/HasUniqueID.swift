//
//  HasUniqueID.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

typealias UniqueID = String

protocol HasUniqueID: class {
    
    var uniqueID: UniqueID { get set }
    
}

