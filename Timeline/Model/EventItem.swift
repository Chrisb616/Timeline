//
//  EventItem.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/22/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

protocol EventItem: HasUniqueID, Temporal {
    
    weak var event: Event? { get set }
    
}
