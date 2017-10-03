//
//  URL.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/17/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

extension URL {
    
    var nsURL: NSURL? { return NSURL(string: self.absoluteString) }
    
}
