//
//  UniqueIDGenerator.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/7/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class UniqueIDGenerator {
    
    private init() {}
    static let instance = UniqueIDGenerator()
    
    //MARK: - New IDs
    var event: UniqueID {
        let resultID = loadEventID() ?? "EV000000"
        
        let newID = advanced(resultID)
        saveEventID(newID)
        
        return newID
    }
    
    var moment: UniqueID {
        let resultID = loadMomentID() ?? "MO000000"
        
        let newID = advanced(resultID)
        saveMomentID(newID)
        
        return newID
    }
    
    var image: UniqueID {
        let resultID = loadImageID() ?? "IM000000"
        
        let newID = advanced(resultID)
        saveImageID(newID)
        
        return newID
    }
    
    //MARK: - Advance Functions
    private func advanced(_ ID: String) -> String {
        var characters = ID
        
        if characters.count == 0 { return "0" }
        
        let last = characters.removeLast() as Character
        
        
        if last == "Z" {
            var truncatedID: String = ""
            
            for character in characters {
                truncatedID.append(character)
            }
            
            characters = advanced(truncatedID)
            
            characters.append("0")
        } else {
            characters.append(advanced(character: last))
        }
        
        var result: String = ""
        
        for character in characters {
            result.append(character)
        }
        
        return result
    }
    
    private func advanced(character: Character) -> Character {
        switch character {
        case "0": return "1"
        case "1": return "2"
        case "2": return "3"
        case "3": return "4"
        case "4": return "5"
        case "5": return "6"
        case "6": return "7"
        case "7": return "8"
        case "8": return "9"
        case "9": return "A"
        case "A": return "B"
        case "B": return "C"
        case "C": return "D"
        case "D": return "E"
        case "E": return "F"
        case "F": return "G"
        case "G": return "H"
        case "H": return "I"
        case "I": return "J"
        case "J": return "K"
        case "K": return "L"
        case "L": return "M"
        case "M": return "N"
        case "N": return "O"
        case "O": return "P"
        case "P": return "Q"
        case "Q": return "R"
        case "R": return "S"
        case "S": return "T"
        case "T": return "U"
        case "U": return "V"
        case "V": return "W"
        case "W": return "X"
        case "X": return "Y"
        case "Y": return "Z"
        default: return "0"
        }
    }
    
    //MARK: - User Defaults
    private let defaults = UserDefaults.standard
    
    //MARK: Keys
    private let eventKey = "eventID"
    private let momentKey = "momentID"
    private let imageKey = "imageID"
    
    //MARK: - ID Management
    
    //MARK: Save IDs
    private func saveEventID(_ ID: String) {
        defaults.set(ID, forKey: eventKey)
    }
    
    private func saveMomentID(_ ID: String) {
        defaults.set(ID, forKey: momentKey)
    }
    
    private func saveImageID(_ ID: String) {
        defaults.set(ID, forKey: imageKey)
    }
    
    //MARK: Load IDs
    private func loadEventID() -> String? {
        guard let eventID = defaults.string(forKey: eventKey) else { return nil }
        return eventID
    }
    
    private func loadMomentID() -> String? {
        guard let momentID = defaults.string(forKey: momentKey) else { return nil }
        return momentID
    }
    
    private func loadImageID() -> String? {
        guard let imageID = defaults.string(forKey: imageKey) else { return nil }
        return imageID
    }
    
    //MARK: - Remove Data
    
    func removeAllIData() {
        removeEventIDSaveData()
        removeMomentIDSaveData()
        removeImageIDSaveData()
    }
    
    func removeEventIDSaveData() {
        defaults.removeObject(forKey: eventKey)
    }
    
    func removeMomentIDSaveData() {
        defaults.removeObject(forKey: momentKey)
    }
    
    func removeImageIDSaveData() {
        defaults.removeObject(forKey: imageKey)
    }
    
    
}

