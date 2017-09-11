//
//  IndexedDictionary.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/10/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

struct IndexedDictionary<T: HasUniqueID> {
    private var keys = [UniqueID:Int]()
    private var values = [T]()
    
    var all: [T] { return values }
    
    var uniqueIDs: [UniqueID] {
        var uniqueIDs = [UniqueID]()
        
        for key in keys.keys {
            uniqueIDs.append(key)
        }
        
        return uniqueIDs
    }
    
    var count: Int { return values.count }
    var isEmpty: Bool { return values.count == 0 }
    
    //MARK: - Change Values
    mutating func add(_ item: T) {
        
        if keys[item.uniqueID] != nil { print("WARNING: Unique ID for new item (\(item.uniqueID)) is already present in Indexed Dictionary ") }
        
        let newIndex = values.count
        values.append(item)
        keys[item.uniqueID] = newIndex
        
    }
    
    mutating func add(_ items: [T]) {
        
        for item in items {
            self.add(item)
        }
        
    }
    
    mutating func remove(_ item: T) {
        guard let index = keys[item.uniqueID] else { return }
        values.remove(at: index)
        
        keys.removeAll()
        
        for (index, item) in values.enumerated() {
            keys.updateValue(index, forKey: item.uniqueID)
        }
    }
    
    mutating func remove(itemWithUniqueID uniqueID: UniqueID) {
        guard let index = keys[uniqueID] else { return }
        values.remove(at: index)
        
        keys.removeAll()
        
        for (index, item) in values.enumerated() {
            keys.updateValue(index, forKey: item.uniqueID)
        }
        
    }
    
    //MARK: - Find Values
    func at(index: Int) -> T {
        return values[index]
    }
    func with(uniqueID: UniqueID) -> T? {
        guard let index = keys[uniqueID] else { return nil }
        return values[index]
    }
    
    //MARK: - Clear Values
    mutating func clear() {
        keys.removeAll()
        values.removeAll()
    }
    
    //MARK: - Retrieve Items
    var random: T {
        let rand = Int(arc4random_uniform(UInt32(count)))
        
        return at(index: rand)
    }
    
    var last: T? {
        return all.last
    }
    
    func firstMatch(_ predicate: (T)->Bool) -> T? {
        for item in all {
            if predicate(item) {
                return item
            }
        }
        
        return nil
    }
}
