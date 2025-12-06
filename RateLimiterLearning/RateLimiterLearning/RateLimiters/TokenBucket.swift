//
//  TokenBucket.swift
//  RateLimiterLearning
//
//  Created by Iron Man on 24/11/25.
//
import Foundation

final class TokenBucket {
    private let capacity: Double
    private let refillRate: Double
    
    private var tokens: Double
    private var lastRefil: TimeInterval
    private let lock = NSLock()
    
    init(maxRequests capacity: Double, inTime time: TimeInterval) {
        self.capacity = capacity
        self.refillRate = capacity / time
        self.tokens = capacity
        self.lastRefil = Date().timeIntervalSince1970
    }
    
    func tryAcquire() -> Bool {
        lock.lock()
        defer {
            lock.unlock()
        }
        refill()
        
        guard tokens >= 1 else { return false }
        
        tokens -= 1
        return true
    }
    
    private func refill() {
        let now = Date().timeIntervalSince1970
        let elapsed = now - lastRefil
        
        if elapsed > 0 {
            tokens = min(capacity, tokens + elapsed * refillRate)
            lastRefil = now
        }
    }
}


/*
 Cons
 
 1. Bursty behaviour is allowed - sometimes this is BAD
    ex:
        capacity = 10
        refillRate = 1/sec
        
        User opens the app -> bucket initially full -> app may fire 10 request instantly -> backend spike
 
 2. Hard to sync limits acroos multiple devices/user
 
 3. Time-based accuracy depends on device clock
    
    ex: User changes device time manually
 
    Fix: Use monotonic clock(CACurrentMediaTime())
 
 4. Token bucket does not spread requests evenly
 
 
 */
