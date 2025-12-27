//
//  SpacedRevisionScheduler.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//

import Foundation

struct SpacedRevisionScheduler {
    
    private static let intervals = [1, 3, 7, 14, 30]
    
    static func nextRevisionDate(from base: Date, step: Int16) -> Date {
        let index = Int(step) % intervals.count
        return Calendar.current.date(
            byAdding: .day,
//            byAdding: .second,
            value: intervals[index],
            to: base
        )!
    }
    
    static func advance(step: Int16) -> Int16 {
        Int16((Int(step) + 1) % intervals.count)
    }
    
    static func rewind() -> Int16 { 0 }
}
