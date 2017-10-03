//
//  Dictionary.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/13/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

extension Dictionary {
    
    var valuesArray: [Value] {
        return Array(self.values)
    }
    
    var keysArray: [Key] {
        return Array(self.keys)
    }
    
}
