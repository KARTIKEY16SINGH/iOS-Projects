//
//  Retry.swift
//  RateLimiterLearning
//
//  Created by Iron Man on 26/11/25.
//

import Foundation

struct RetryEngine {
    private let attempts: Int
    private let baseDelay: TimeInterval
    private let maxDelay: TimeInterval
    
    init(attempts: Int, baseDelay: TimeInterval, maxDelay: TimeInterval) {
        self.attempts = attempts
        self.baseDelay = baseDelay
        self.maxDelay = maxDelay
    }
    
    private func jitterDelayFull(attempt: Int) -> TimeInterval {
        let exp = min(maxDelay, baseDelay * pow(2.0, Double(attempt - 1)))
        return Double.random(in: 0 ... exp)
    }
    
    func run<Result>(
        operation: @escaping (_ completion: @escaping (Result?, Error?) -> Void ) -> Void,
        completion: @escaping (Result?, Error?) -> Void
    ) {
        attemptRun(currentAttempt: 0, lastError: nil, operation: operation, completion: completion)
    }
    
    private func attemptRun<Result>(
        currentAttempt: Int,
        lastError: Error?,
        operation: @escaping (_ completion: @escaping (Result?, Error?) -> Void ) -> Void,
        completion: @escaping (Result?, Error?) -> Void
    ) {
        operation { result, error in
            if let result {
                print("\(#function) Found Result - \(result)")
                completion(result, nil)
                return
            }
            
            let error = error ?? NSError(domain: "RetryEngine", code: -1)
            
            if currentAttempt > attempts {
                print("\(#function) Attempts exhausted - \(currentAttempt)")
                completion(nil, error)
                return
            }
            
            let delay = jitterDelayFull(attempt: currentAttempt)
            print("\(#function) Retrying with delay - \(delay)")
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                
                self.attemptRun(currentAttempt: currentAttempt + 1, lastError: error, operation: operation, completion: completion)
                
            }
        }
    }
}
