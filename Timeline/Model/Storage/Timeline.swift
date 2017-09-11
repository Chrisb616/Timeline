//
//  Timeline.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

class Timeline {
    
    private var dictionary =
        [Int: // Year
            [Int: // Month
                [Int: // Day
                    [Int: // Hour
                        [Int: // Minute
                            [Int: //Second
                                [UniqueID:Bool]]]]]]]()
    
    init() {
        
    }
    
    //MARK: - Add or Remove
    
    func addEvent(_ event: Event) {
        
        for second in event.dateRange.allSeconds {
            
            if var yearDict = dictionary[second.year] {
                
                if var monthDict = yearDict[second.month] {
                    
                    if var dayDict = monthDict[second.day] {
                        
                        if var hourDict = dayDict[second.hour] {
                            
                            if var minuteDict = hourDict[second.minute] {
                                
                                if var secondDict = minuteDict[second.second] {
                                    
                                    secondDict.updateValue(true, forKey: event.uniqueID)
                                    
                                    minuteDict.updateValue(secondDict, forKey: second.second)
                                    
                                } else {
                                    
                                    let newDict = [event.uniqueID:true]
                                    
                                    minuteDict.updateValue(newDict, forKey: second.second)
                                    
                                }
                                
                                hourDict.updateValue(minuteDict, forKey: second.minute)
                                
                            } else {
                                
                                let newDict = [second.second:[event.uniqueID:true]]
                                
                                hourDict.updateValue(newDict, forKey: second.minute)
                                
                            }
                            
                            dayDict.updateValue(hourDict, forKey: second.hour)
                            
                        } else {
                            
                            let newDict = [second.minute:[second.second:[event.uniqueID:true]]]
                            
                            dayDict.updateValue(newDict, forKey: second.hour)
                            
                        }
                        
                        monthDict.updateValue(dayDict, forKey: second.day)
                        
                    } else {
                        
                        let newDict =
                            [second.hour:
                                [second.minute:
                                    [second.second:
                                        [event.uniqueID:true]]]]
                        
                        monthDict.updateValue(newDict, forKey: second.day)
                        
                    }
                    
                    yearDict.updateValue(monthDict, forKey: second.month)
                    
                } else {
                    
                    let newDict =
                        [second.day:
                            [second.hour:
                                [second.minute:
                                    [second.second:
                                        [event.uniqueID:true]]]]]
                    
                    yearDict.updateValue(newDict, forKey: second.month)
                    
                }
                
                dictionary.updateValue(yearDict, forKey: second.year)
                
            } else {
                
                let newDict =
                    [second.month:
                            [second.day:
                                [second.hour:
                                    [second.minute:
                                        [second.second:
                                            [event.uniqueID:true]]]]]]
                
                dictionary.updateValue(newDict, forKey: second.year)
                
            }
            
        }
        
    }
    
    func removeEvent(_ event: Event) {
        
        for second in event.dateRange.allSeconds {
            
            if var yearDict = dictionary[second.year] {
                
                if var monthDict = yearDict[second.month] {
                    
                    if var dayDict = monthDict[second.day] {
                        
                        if var hourDict = dayDict[second.hour] {
                            
                            if var minuteDict = hourDict[second.minute] {
                                
                                if var secondDict = minuteDict[second.second] {
                                    
                                    secondDict.removeValue(forKey: event.uniqueID)
                                    
                                    minuteDict.updateValue(secondDict, forKey: second.second)
                                    
                                }
                                
                                hourDict.updateValue(minuteDict, forKey: second.minute)
                                
                            }
                            
                            dayDict.updateValue(hourDict, forKey: second.hour)
                            
                        }
                        
                        monthDict.updateValue(dayDict, forKey: second.day)
                        
                    }
                    
                    yearDict.updateValue(monthDict, forKey: second.month)
                    
                }
                
                dictionary.updateValue(yearDict, forKey: second.year)
                
            }
            
        }
        
    }
    
    //MARK: - Queries
    
    func queryEventIDs(forSecond second: Int, minute: Int, hour: Int, day: Int, month: Int, year: Int) -> [UniqueID:Bool] {
        let minuteDict = minuteDictionary(minute: minute, hour: hour, day: day, month: month, year: year)
        
        return minuteDict[second] ?? [:]
    }
    
    func queryEventIDs(forMinute minute: Int, hour: Int, day: Int, month: Int, year: Int) -> [UniqueID:Bool] {
        let minuteDict = minuteDictionary(minute: minute, hour: hour, day: day, month: month, year: year)
        
        var allEventIDs = [UniqueID:Bool]()
        
        for second in minuteDict.keys {
            let secondEvents = queryEventIDs(forSecond: second, minute: minute, hour: hour, day: day, month: month, year: year)
            for event in secondEvents {
                allEventIDs.updateValue(true, forKey: event.key)
            }
        }
        
        return allEventIDs
    }
    
    func queryEventIDs(forHour hour: Int, day: Int, month: Int, year: Int) -> [UniqueID:Bool] {
        let hourDict = hourDictionary(hour: hour, day: day, month: month, year: year)
        
        var allEventIDs = [UniqueID:Bool]()
        
        for minute in hourDict.keys {
            let minuteEvents = queryEventIDs(forMinute: minute, hour: hour, day: day, month: month, year: year)
            for event in minuteEvents {
                allEventIDs.updateValue(true, forKey: event.key)
            }
        }
        
        return allEventIDs
    }
    
    func queryEventIDs(forDay day: Int, month: Int, year: Int) -> [UniqueID:Bool] {
        let dayDict = dayDictionary(day: day, month: month, year: year)
        
        var allEventIDs = [UniqueID:Bool]()
        
        for hour in dayDict.keys {
            let hourEvents = queryEventIDs(forHour: hour, day: day, month: month, year: year)
            for event in hourEvents {
                allEventIDs.updateValue(true, forKey: event.key)
            }
        }
        
        return allEventIDs
    }
    
    func queryEventIDs(forMonth month: Int, year: Int) -> [UniqueID:Bool] {
        let monthDict = monthDictionary(month: month, year: year)
        
        var allEventIDs = [UniqueID:Bool]()
        
        for day in monthDict.keys {
            let monthEvents = queryEventIDs(forDay: day, month: month, year: year)
            for event in monthEvents {
                allEventIDs.updateValue(true, forKey: event.key)
            }
        }
        
        return allEventIDs
    }
    
    func queryEventIDs(forYear year: Int) -> [UniqueID:Bool] {
        let yearDict = yearDictionary(year: year)
        
        var allEventIDs = [UniqueID:Bool]()
        
        for month in yearDict.keys {
            let yearEvents = queryEventIDs(forMonth: month, year: year)
            for event in yearEvents {
                allEventIDs.updateValue(true, forKey: event.key)
            }
        }
        
        return allEventIDs
    }
    
    //MARK: - Individual Time-Based Dictionaries
    
    private func yearDictionary(year: Int) ->
        [Int: // Month
        [Int: // Day
        [Int: // Hour
        [Int: // Minute
        [Int: //Second
        [UniqueID:Bool]]]]]]
    {
        if let yearDictionary = dictionary[year] {
            return yearDictionary
        } else {
            return [:]
        }
    }
    private func monthDictionary(month: Int, year: Int) ->
        [Int: // Day
        [Int: // Hour
        [Int: // Minute
        [Int: //Second
        [UniqueID:Bool]]]]]
    {
        if let monthDictionary = yearDictionary(year: year)[month] {
            return monthDictionary
        } else {
            return [:]
        }
    }
    
    private func dayDictionary(day: Int, month: Int, year: Int) ->
        [Int: // Hour
        [Int: // Minute
        [Int: //Second
        [UniqueID:Bool]]]]
    {
        if let dayDictionary = monthDictionary(month: month, year: year)[day] {
            return dayDictionary
        } else {
            return [:]
        }
    }
    
    private func hourDictionary(hour: Int, day: Int, month: Int, year: Int) ->
        [Int: // Minute
        [Int: //Second
        [UniqueID:Bool]]]
    {
        if let hourDictionary = dayDictionary(day: day, month: month, year: year)[hour] {
            return hourDictionary
        } else {
            return [:]
        }
    }
    
    private func minuteDictionary(minute: Int, hour: Int, day: Int, month: Int, year: Int) -> [Int:[UniqueID:Bool]] {
        if let minuteDictionary = hourDictionary(hour: hour, day: day, month: month, year: year)[minute] {
            return minuteDictionary
        } else {
            return [:]
        }
    }
    
    
}
