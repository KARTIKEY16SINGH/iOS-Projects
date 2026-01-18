//
//  Date+Extensions.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//

import Foundation

extension Date {
    
    /// 08:00 of the given date → 08:00 of next day
    static func revisionWindow(for date: Date) -> (start: Date, end: Date) {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents(
            [.year, .month, .day],
            from: date
        )
        components.hour = 8
        components.minute = 0
        components.second = 0
        
        let start = calendar.date(from: components)!
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        
        return (start, end)
    }
}

extension Date {
    static func todayRange() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        return (start, end)
    }
}

extension Date {
    
    /// Custom "Today" window:
    /// From today 08:00 → tomorrow 08:00 (local time)
    static func todayFrom8AMRange() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let now = Date()
        
        var startComponents = calendar.dateComponents(
            [.year, .month, .day],
            from: now
        )
        startComponents.hour = 8
        startComponents.minute = 0
        startComponents.second = 0
        
        let start = calendar.date(from: startComponents)!
        
        let end = calendar.date(
            byAdding: .day,
            value: 1,
            to: start
        )!
        
        // If current time is before 8 AM, shift window back one day
        if now < start {
            let adjustedStart = calendar.date(
                byAdding: .day,
                value: -1,
                to: start
            )!
            let adjustedEnd = start
            debugPrint("Date todayFrom8AMRange start -> \(adjustedStart) , end -> \(adjustedEnd) ")
            return (adjustedStart, adjustedEnd)
        }
        debugPrint("Date todayFrom8AMRange start -> \(start) , end -> \(end) ")
        return (start, end)
    }
}
