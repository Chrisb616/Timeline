//
//  Int.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/12/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

extension Int {
    
    var wordString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return numberFormatter.string(from: self.nsNumber) ?? ""
    }
    
    var nsNumber: NSNumber {
        return NSNumber(integerLiteral: self)
    }
    
}

