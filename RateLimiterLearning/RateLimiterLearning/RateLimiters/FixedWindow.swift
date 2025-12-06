//
//  FixedWindow.swift
//  RateLimiterLearning
//
//  Created by Iron Man on 24/11/25.
//

import Foundation

final class FixedWindowRateLimiter {
    private let maxRequests: Int
    private let interval: TimeInterval
    
    private var requestCount = 0
    private var windowStart = Date()
    private let lock = NSLock()
    
    init(maxRequests: Int, per interval: TimeInterval) {
        self.maxRequests = maxRequests
        self.interval = interval
    }
    
    func tryAcquire() -> Bool {
        lock.lock()
        
        defer {
            lock.unlock()
        }
        
        let now = Date()
        if now.timeIntervalSince(windowStart) >= interval {
            windowStart = now
            requestCount = 0
        }
        
        guard requestCount < maxRequests else {
            return false
        }
        
        requestCount += 1
        return true
    }
}


/*
 
 Cons
 
 1. Boundary Burst: two windows allow double usage in a small period
 2. Per device only
 3. For many endpoints you may need many limiters; storing thousands of limiters is memory/cpu trivial on modern devices but logic complexity grows
 
 */
