//
//  DateUtils+Ext.swift
//  Ludo
//
//  Created by mohsen mokhtari on 5/22/23.
//

import Foundation
extension Date {
    static func addMonth(_ month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: month, to: Date())!
    }
    
    static func addDay(_ day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: Date())!
    }
    
    static func addYear(_ year: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: Date())!
    }
    
    static func addWeek(_ week: Int) -> Date {
        return Calendar.current.date(byAdding: .weekOfMonth, value: week, to: Date())!
    }
    
    static func addHour(_ hour: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hour, to: Date())!
    }
    
    static func addMinute(_ minute: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minute, to: Date())!
    }
    
    static func addSecond(_ second: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: second, to: Date())!
    }
    
    static func add(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: Date())!
    }
    
    static func add(_ component: Calendar.Component, value: Int, date: Date) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: date)!
    }
    
    static func get(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: Date())
    }
    
    static func get(_ component: Calendar.Component, date: Date) -> Int {
        return Calendar.current.component(component, from: date)
    }
    
    static func get(_ component: Calendar.Component, date: Date, calendar: Calendar) -> Int {
        return calendar.component(component, from: date)
    }
    
    static func get(_ component: Calendar.Component, calendar: Calendar) -> Int {
        return calendar.component(component, from: Date())
    }
    
    static func get(_ component: Calendar.Component, date: Date, calendar: Calendar, locale: Locale) -> Int {
        return calendar.component(component, from: date)
    }
    
    
    
}
