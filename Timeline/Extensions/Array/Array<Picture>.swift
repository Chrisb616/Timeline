//
//  Array<Picture>.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/11/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

extension Array where Element == Picture {
    
    var chronological: [Picture] {
        return self.sorted{ $0.date < $1.date }
    }
    
}
