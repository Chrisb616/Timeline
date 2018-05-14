//
//  Date.swift
//  Timeline
//
//  Created by Christopher Boynton on 9/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import Foundation

extension Date {
    
    static func fromComponents(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date? {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "y-M-d-H-m-s"
        
        return dateFormatter.date(from: "\(year)-\(month)-\(day)-\(hour)-\(minute)-\(second)")
    }
    
    var month: Int {
        return Calendar.current.dateComponents([.month], from: self).month ?? 0
    }
    var day: Int {
        return Calendar.current.dateComponents([.day], from: self).day ?? 0
    }
    var year: Int {
        return Calendar.current.dateComponents([.year], from: self).year ?? 0
    }
    var second: Int {
        return Calendar.current.dateComponents([.second], from: self).second ?? 0
    }
    var minute: Int {
        return Calendar.current.dateComponents([.minute], from: self).minute ?? 0
    }
    var hour: Int {
        return Calendar.current.dateComponents([.hour], from: self).hour ?? 0
    }
    
    func durationStringSince(pastDate: Date) -> String {
        
        let components = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: pastDate, to: self)
        
        var durationString = ""
        
        func addCommaIfNeeded() {
            if durationString != "" { durationString += ", "}
        }
        
        guard
            let year = components.year,
            let month = components.month,
            let day = components.day,
            let hour = components.hour,
            let minute = components.minute,
            let second = components.second
            else { return "" }
        
        if year == 1 {
            durationString += "1 year"
        } else if year > 1 {
            durationString += "\(year.wordString) years"
        }
        
        if month == 1 {
            addCommaIfNeeded()
            durationString += "1 month"
        } else if month > 1 {
            addCommaIfNeeded()
            durationString += "\(month.wordString) months"
        }
        
        if day == 1 {
            addCommaIfNeeded()
            durationString += "1 day"
        } else if day > 1 {
            addCommaIfNeeded()
            durationString += "\(day.wordString) days"
        }
        
        if hour == 1 {
            addCommaIfNeeded()
            durationString += "1 hour"
        } else if hour > 1 {
            addCommaIfNeeded()
            durationString += "\(hour.wordString) hours"
        }
        
        if minute == 1 {
            addCommaIfNeeded()
            durationString += "1 minute"
        } else if minute > 1 {
            addCommaIfNeeded()
            durationString += "\(minute.wordString) minutes"
        }
        
        if second == 1 {
            addCommaIfNeeded()
            durationString += "1 second"
        } else if second > 1 {
            addCommaIfNeeded()
            durationString += "\(second.wordString) seconds"
        }
        
        return durationString
    }
    
    //Date formatted as string in simple function
    func formatted(as string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = string
        return formatter.string(from: self)
    }
    
    //Use that function to find the weekday as a string
    var weekday: String {
        return self.formatted(as: "EEEE")
    }
    
    func yearsSince(_ date: Date) -> Int {
        if date.month < self.month {
            return self.year - date.year
        } else if date.month > self.month {
            return self.year - date.year - 1
        } else {
            if date.day <= self.day {
                return self.year - date.year
            } else {
                return self.year - date.year - 1
            }
        }
    }
    
    func monthsSince(_ date: Date) -> Int {
        if date.day <= self.day {
            return (self.year - date.year) * 12 + (self.month - date.month)
        } else {
            return (self.year - date.year) * 12 + (self.month - date.month - 1)
        }
    }
    
    var toSaveString: String {
        return self.formatted(as: "y-M-d-H-m-s")
    }
    
    static func fromSaveString(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.dateFormat = "y-M-d-H-m-s"
        
        return dateFormatter.date(from: string)
    }
    
}
