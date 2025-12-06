import UIKit

//var greeting = "Hello, playground"

//func getRandomInt(start: Int, end: Int) -> Int {
//    var res: Int!
//    for _ in start...Int.random(in: (start+1)...(end+1)) {
//        res = Int.random(in: start...end)
//    }
//    return res
//}
//
//getRandomInt(start: 1, end: 15)
//
//let numbers = [1,3,5,7,9]
//let result = numbers.map{
//    $0 * 10
//}

//struct Solution {
//    func countSubstrings(_ s: String) -> Int {
//        var res: Int = 0
//        let arr = Array(s)
//        var dp:[[Bool]] = Array(repeating: Array(repeating:false, count: s.count), count: s.count)
//
//        for length in 0..<arr.count {
//            for index in length..<arr.count {
//                let startIndx = index - length
//                let value = (arr[startIndx] == arr[index]) || checkValid(dp: dp, strt: startIndx, end: index)
//                dp[startIndx][index] = value
//                if value {
//                    res += 1
//                }
//            }
//        }
//        return res
//    }
//
//    private func checkValid(dp: [[Bool]], strt: Int, end: Int) -> Bool {
//        guard strt <= end else {return true}
//        return dp[strt][end]
//    }
//}

//Solution().countSubstrings("abc")

let arr: [Int?] = [nil, nil, nil, nil]

for element in arr {
    print("element = ",element)
}

class A {
    let storedPropertyA = 10
    lazy var lazyVarA = {
        "I am lazy \(self.storedPropertyA)"
    }()
    
    var closureA : (() -> String)?
    
    func function1() {
        print(lazyVarA)
        closureA = {
            "I am lazy \(self.storedPropertyA)"
        }
        closureA?()
    }
}

let objectA = A()
objectA.function1()


class Node<T> {
    var value: T!
    var next: Node?
}
class LinkedList<T> {
    private var _head: Node<T>?
    private var _tail: Node<T>?
    
    
}

class View {
    var viewModel: ViewModel?
    func initialiseModel() {
        viewModel = ViewModel(_view: self)
    }
    deinit {
//        viewModel = nil
        print("view deinitialised")
    }
}

class ViewModel {
    unowned var view: View?
    init(_view: View) {
        view = _view
    }
    deinit {
        print("ViewModel deinitialised")
    }
}


var viewObj: View? = View()
viewObj?.initialiseModel()
viewObj = nil

let stideRes = stride(from: 31, through: 0, by: -1)
print(type(of: stideRes))

for index in stideRes {
    print(index)
}


func jitterDelayFull(base: TimeInterval, attempt: Int, maxDelay: TimeInterval) -> TimeInterval {
    let exp = min(base * pow(2.0, Double(attempt - 1)), maxDelay)
    return Double.random(in: 0...exp)
}


func retryExponentialWithFullJitter<Result>(
    attempts: Int = 4,
    baseDelay: TimeInterval = 0.5,
    maxDelay: TimeInterval = 8.0,
    operation: @escaping (_ completion: @escaping (Result?, Error?) -> Void) -> Void,
    completion: @escaping (Result?, Error?) -> Void
) {
    func attemptRun(_ currentAttempt: Int, _ lastError: Error?) {
        operation { result, error in
            if let result = result {
                // SUCCESS -> finish
                completion(result, nil)
                return
            }

            let error = error ?? NSError(domain: "Retry", code: 0)

            // Last attempt → return error
            if currentAttempt >= attempts {
                completion(nil, error)
                return
            }

            // Compute jittered delay
            let delay = jitterDelayFull(base: baseDelay,
                                        attempt: currentAttempt,
                                        maxDelay: maxDelay)

            // Schedule next attempt
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                attemptRun(currentAttempt + 1, error)
            }
        }
    }

    attemptRun(1, nil)
}

//retryExponentialWithFullJitter(operation: <#T##(@escaping (Result?, (any Error)?) -> Void) -> Void##(@escaping (Result?, (any Error)?) -> Void) -> Void##(_ completion: @escaping (Result?, (any Error)?) -> Void) -> Void#>, completion: <#T##(Result?, (any Error)?) -> Void#>)

let numberSemaphore = DispatchSemaphore(value: 1)
let characterSemaphore = DispatchSemaphore(value: 0)

DispatchQueue.global().async {
    for num in 1...26 {
        numberSemaphore.wait()
        print(num, terminator: ",")
        characterSemaphore.signal()
    }
}

DispatchQueue.global().async {
    let character = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    for char in character {
        characterSemaphore.wait()
        print(char, terminator: ",")
        numberSemaphore.signal()
    }
}


RunLoop.main.run(until: Date() + 2)

struct Counter {
    var count = 0
    mutating func inc() { count += 1 }
}

func makeCounter() -> () -> Int {
    var c = Counter()
    return {
        c.inc()
        return c.count
    }
}

let counter1 = makeCounter()
print(counter1())   // ?
print(counter1())   // ?

class Person {
    let name: String
    var friends: [Person] = []
    var greet: (() -> Void)?

    init(_ name: String) {
        self.name = name
        print("init:", name)
    }

    deinit {
        print("deinit:", name)
    }
}

do {
    let p1 = Person("A")
    let p2 = Person("B")
    p1.friends.append(p2)
    p2.greet = { print("Hi from", p2.name) }
}
print("Done")

func test() -> [() -> Int] {
    var result: [() -> Int] = []
    for i in 1...3 {
        result.append { i }
    }
    return result
}

let funcs = test()
print(funcs[0]())
print(funcs[1]())
print(funcs[2]())

let queue = DispatchQueue(label: "x", attributes: .concurrent)

queue.async {
    print("A")
    queue.sync {    // DEADLOCK
        print("B")
    }
    print("C")
}

