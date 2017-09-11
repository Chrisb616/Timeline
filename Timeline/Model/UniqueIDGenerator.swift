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
    var event: String {
        let resultID = loadEventID() ?? "EV000000"
        
        let newID = advanced(resultID)
        saveEventID(newID)
        
        return newID
    }
    
    var picture: String {
        let resultID = loadPictureID() ?? "PI000000"
        
        let newID = advanced(resultID)
        savePictureID(newID)
        
        return newID
    }
    
    //MARK: - Advance Functions
    private func advanced(_ ID: String) -> String {
        var characters = ID.characters
        
        if characters.count == 0 { return "0" }
        
        let last = characters.removeLast() as Character
        
        
        if last == "Z" {
            var truncatedID: String = ""
            
            for character in characters {
                truncatedID.append(character)
            }
            
            characters = advanced(truncatedID).characters
            
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
    private let pictureKey = "pictureID"
    
    //MARK: - ID Management
    
    //MARK: Save IDs
    private func saveEventID(_ ID: String) {
        defaults.set(ID, forKey: eventKey)
    }
    
    private func savePictureID(_ ID: String) {
        defaults.set(ID, forKey: pictureKey)
    }
    
    //MARK: Load IDs
    private func loadEventID() -> String? {
        guard let eventID = defaults.string(forKey: eventKey) else { return nil }
        return eventID
    }
    
    private func loadPictureID() -> String? {
        guard let pictureID = defaults.string(forKey: pictureKey) else { return nil }
        return pictureID
    }
    
    //MARK: - Remove Data
    
    func removeAllIDData() {
        removeEventIDSaveData()
        removePictureIDSaveData()
    }
    
    func removeEventIDSaveData() {
        defaults.removeObject(forKey: eventKey)
    }
    
    func removePictureIDSaveData() {
        defaults.removeObject(forKey: pictureKey)
    }
    
    
}

