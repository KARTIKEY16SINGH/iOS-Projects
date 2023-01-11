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
