import Foundation
import UIKit
import os
//func rgb(_ r: Int, _ g: Int, _ b: Int) -> String {
//    let input = [r,g,b]
//    return input.map({ $0 > 255 ? 255 : $0 < 0 ? 0 : $0
//    }).reduce("") { res, color in
//        let secondComp = color & 0x0F
//        let firstComp = (color >> 4) & 0x0F
//        print(firstComp, secondComp)
//        return res + [firstComp, secondComp].reduce("") { res, hex in
//            if hex < 10 {
//                return res + "\(hex)"
//            }
//            let temp = ["A","B","C","D","E","F"]
//            return res + "\(temp[hex-10])"
//        }
//    }
//}
//
//rgb(255, 255, 255)
//rgb(0, 0, 0)
//rgb(148, 0, 211)
//rgb(255, 255, 300)

//func solution(_ string:String) -> Int {
////    I          1
////    V          5
////    X          10
////    L          50
////    C          100
////    D          500
////    M          1,000
//    var last = 0
//    var res = 0
//    string.forEach { char in
//        var cur = 0
//        switch char {
//        case "I": cur = 1
//        case "V": cur = 5
//        case "X": cur = 10
//        case "L": cur = 50
//        case "C": cur = 100
//        case "D": cur = 500
//        default: cur = 1000
//        }
//        if last < cur {
//            last = cur - last
//        } else {
//            res += last
//            last = cur
//        }
//    }
//    res += last
//    return res
//}
//solution("XXI")
//solution("MMVIII")
//solution("MCMXC")
//solution("MDCLXVI")

//func digitalRoot(of number: Int) -> Int {
//    var num = number
//    var res = number
//    while res >= 10 {
//        num = res
//        res = 0
//        while num != 0 {
//            res += num % 10
//            num = num / 10
//        }
//    }
//    return res
//}
//digitalRoot(of: 16)
//digitalRoot(of: 942)
//digitalRoot(of: 132189)
//digitalRoot(of: 493193)
//
//func digitalRoot1(of number: Int) -> Int {
//    print((number - 1) % 9)
//    return (1 + (number - 1) % 9)
//}
//digitalRoot1(of: 16)
//digitalRoot1(of: 942)
//digitalRoot1(of: 132189)
//digitalRoot1(of: 493193)

//let keys = [ "M", "D", "C", "L", "X", "V", "I"]
//let map = [
//    "I": 1,
//    "V": 5,
//    "X": 10,
//    "L": 50,
//    "C": 100,
//    "D": 500,
//    "M": 1000
//]
//func toRoman(_ number: Int) -> String {
//    permute(number, 0, [], -1)
//    return ans.reduce("", +)
//}
//var maxLength = 5
//var ans = Array<String>()
//func permute(_ number: Int, _ sum: Int, _ cur: [String], _ pos: Int) {
//    if number == sum && cur.count < maxLength {
//        ans = cur
//        maxLength = cur.count
//        return
//    }
//    if sum >= 2 * number || cur.count > maxLength {
//        return
//    }
//    for key in keys {
////        print("cur", cur)
//        var isAdd = true
//        var value = 0
//        if pos >= 0 {
//            if map[cur[pos]]! < map[key]! {
//                value = map[cur[pos]]!
//                isAdd = false
//            }
//        }
//        if map[key]! - value != value && count(cur, key) {
//        var temp = cur
//        temp.append(key)
////        print("Temp", temp)
//        permute(number, sum - value + map[key]! - value, temp, pos + 1)
//        }
//    }
//}
//
//func count(_ arr: [String], _ key: String) -> Bool {
//    var count = 0
//    for k in arr {
//        if k == key {
//            count += 1
//        }
//        if count == 4 {
//            return false
//        }
//    }
//    return true
//}
//
//toRoman(1990)

//func tongues(_ code: String) -> String {
//    let vowels: [String] = ["a", "i", "y", "e", "o", "u"]
//    let consonents: [String] = ["b", "k", "x", "z", "n", "h", "d", "c", "w", "g", "p", "v", "j", "q", "t", "s", "r", "l", "m", "f"]
//    return code.map { char -> String in
//        if vowels.contains(char.lowercased()) {
//            let index = vowels.firstIndex(of: char.lowercased())
//            let res = vowels[(6 + (index! - 3)) % 6]
//            return char.isLowercase ? res : res.uppercased()
//        }
//        if consonents.contains(char.lowercased()) {
//            let index = consonents.firstIndex(of: char.lowercased())
//            let res = consonents[(consonents.count + (index! - 10)) % consonents.count]
//            return char.isLowercase ? res : res.uppercased()
//        }
//        return "\(char)"
//    }.reduce("", +)
//}
//
//tongues("Ita dotf ni dyca nsaw ecc.")

//var mapNum:[UInt64: UInt64] = [:]
//var mapSum:[UInt64: UInt64] = [:]
//func perimeter(_ n: UInt64) -> UInt64 {
//  // your code
//    var sum: UInt64 = 0
//    _ = fibonaci(n, &sum)
//    return 4 * sum
//}
//
//func fibonaci(_ n: UInt64, _ sum: inout UInt64) -> UInt64 {
////    print("N = ",n,"Sum = ", sum)
////    print("Map Num = ", mapNum)
////    print("Map Sum = ", mapSum)
////    print("\n\n")
//    guard mapNum[n] == nil else {
//        return mapNum[n]!
//    }
//    if n == 0 {
//        sum = 1
//        return 1
//    }
//    if n == 1 {
//        mapSum[1] = 2
//        mapNum[1] = 1
//        sum = 2
//        return 1
//    }
//    let res = fibonaci(n-2, &sum) + fibonaci(n-1, &sum)
//    mapNum[n] = res
//    sum = res + mapSum[mapNum[n-1]!]!
//    mapSum[res] = sum
//    return res
//}
//perimeter(0)
//perimeter(1)
//perimeter(2)
//perimeter(3)
//perimeter(4)
//perimeter(5)
//perimeter(7)
//perimeter(30)

//func tribonacci(_ signature: [Int], _ n: Int) -> [Int] {
//    guard n != 0 else {return []}
//    if n <= 3 {
//        var res = [Int]()
//        for (index, value) in signature.enumerated() {
//            if index == n {
//                return res
//            }
//            res.append(value)
//        }
//        return res
//    }
//    var res = signature
//    (signature.count..<n).forEach{
//        print("$0",$0)
//        res.append(res[$0-3..<$0].reduce(0, +))
//    }
//    return res
//}
//
//tribonacci([1,1,1], 10)//, [1,1,1,3,5,9,17,31,57,105])
//tribonacci([0,0,1], 10)//, [0,0,1,1,2,4,7,13,24,44])
//tribonacci([0,1,1], 10)//, [0, 1, 1, 2, 4, 7, 13, 24, 44, 81])
//tribonacci([1,0,0], 10)//, [1, 0, 0, 1, 1, 2, 4, 7, 13, 24])
//tribonacci([0,0,0], 10)//, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
//tribonacci([1,2,3], 10)//, [1, 2, 3, 6, 11, 20, 37, 68, 125, 230])
//tribonacci([3,2,1], 10)//, [3, 2, 1, 6, 9, 16, 31, 56, 103, 190])
//tribonacci([1,1,1], 1)//, [1])
//tribonacci([300,200,100], 0)//, [])

//enum CompassPoint {
//    case north
//    case west
//    case east
//    case south
//}
//
//let n = CompassPoint.east
//
//n == CompassPoint.west
//
//extension UITextField {
//    open override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        self.borderStyle = .roundedRect
//    }
//}
//
//let txt = UITextField(frame: .infinite).draw(.infinite)
//    txt.borderStyle.rawValue

//func reverse(_ str: String) -> String {
//    str.reduce(""){"\($1)\($0)"}
//}
//
//reverse("hello")
//reverse("rat")
//reverse("alpha")


//class Solution {
//    private let map: [Character: String] = [
//        "2": "abc",
//        "3": "def",
//        "4": "ghi",
//        "5": "jkl",
//        "6": "mno",
//        "7": "pqrs",
//        "8": "tuv",
//        "9": "wxyz"
//    ]
//
//    func letterCombinations(_ digits: String) -> [String] {
//        guard digits.count > 0 else {return []}
//        var res: [String] = []
//        combine(digits, 0, "", &res)
//        return res
//    }
//
//    private func combine(_ subString: String, _ pos: Int, _ cur: String, _ result: inout [String]) {
//        guard pos < subString.count else {
//            result.append(cur)
//            return
//        }
//        map[subString[pos]]?.forEach{ str in
//            combine(subString, pos+1, "\(cur)\(str)", &result)
//        }
//    }
//}
//
//extension String {
//    subscript (_ offset: Int) -> Character {
//        self[index(startIndex, offsetBy: offset)]
//    }
//}
//
//Solution().letterCombinations("245")

//MARK: House were not in circle
//class Solution {
//    func rob(_ nums: [Int]) -> Int {
//        var result: Int = 0
//        result = doRobbing(nums, 0, curSum: 0)
//        return result
////        maximiseRob(nums)
//    }
//
//    private func doRobbing(_ nums: [Int], _ pos: Int, curSum: Int) -> Int {
//        guard pos < nums.count else {
//            return curSum
//        }
//
//        let notInc = doRobbing(nums, pos + 1, curSum: curSum)
//        let inc = doRobbing(nums, pos + 2, curSum: curSum + nums[pos])
//        return inc > notInc ? inc : notInc
//    }
//
//    private func maximiseRob(_ nums:[Int]) -> Int {
//        var dp:[Int] = nums
//        dp.insert(0, at: 0)
//        for (index, value) in nums.enumerated() {
//            guard index > 0 else {
//                dp[index+1] = value
//                continue
//            }
//            let inCur = value + dp[index-1]
//            let notCur = dp[index]
//            dp[index+1] = inCur > notCur ? inCur : notCur
//        }
//        return dp[nums.count]
//    }
//}
//
//Solution().rob([1,2,3,1])
//Solution().rob([2,7,9,3,1])

//MARK: Houses are arranged in circle

//class Solution {
//    func rob(_ nums: [Int]) -> Int {
//        guard nums.count > 1 else {return nums[0]}
//        var forward:[Int] = []
//        var backward:[Int] = []
//
//        for (index, value) in nums.enumerated() {
//            guard index  > 0 else {
//                forward.append(value)
//                continue
//            }
//            let inc = value + (index-2 < 0 ? 0 : forward[index-2])
//            let notInc = forward[index-1]
//            forward.append(inc > notInc ? inc : notInc)
//        }
//
//        for index in stride(from: nums.count-1, through: 0, by: -1) {
//            guard index < nums.count - 1 else {
//                backward.append(nums[index])
//                continue
//            }
//            let inc = nums[index] + (backward.count == 1 ? 0 : backward[1])
//            let notInc = backward[0]
//            backward.insert(inc > notInc ? inc : notInc, at: 0)
//        }
//
//        return forward[nums.count-2] > backward[1] ? forward[nums.count-2] : backward[1]
//    }
//}
//
//Solution().rob([2,7,9,3,1])
//Solution().rob([2,3,2])
//Solution().rob([1,2,3])
//Solution().rob([1,2,3,1])
//Solution().rob([3])


//extension String {
//    static func *(_ str: String, _ mul: Int) -> String {
//        stride(from: 0, to: mul, by: 1).reduce("") { partialResult, el in
//            partialResult + str
//        }
//    }
//}
//
//print("*" * 3)
//
//extension Array {
//    func userMap<K>(_ transform: (Element) -> K?) -> [K?] {
//        var res: [K?] = []
//        for value in self {
//            res.append(transform(value))
//        }
//        return res
//    }
//}
//
//
//enum TransactionType {
//   case debit, credit
//}
//
//class Transaction {
//    let transactionType: TransactionType
//    let amount: Double?
//}
//
//class Account {
//    let accountId: Int
//}
//
//func getAccounts() -> [Account]
//func getTransactionsFromDb(for account: Account) -> [Transaction]
//
//func process(openingBalance: Double) -> Double {
//    let balance = openingBalance
//    let accounts = getAccounts()
//    for a in accounts {
//        let transactions = getTransactionsFromDb(for: a)
//        for t in transactions {
//            switch t {
//            case .debit:
//                balance = balance - t.amount
//            case .credit
//                balance = balance + t.amount
//            }
//        }
//    }
//    return balance
//}

//func loadFile() {}

//func updateLable() {
//    let retrunStr = ""
//
//    DispatchQueue.global(qos: .background).async {
//        let res = loadFile()
//        DispatchQueue.main.async {
//            updateLable()
//        }
//    }
//}


//func getMax(_ arr: [Int]) -> (firstMax:Int, secondMax: Int) {
//    var firstMax = Int.min
//    var seconMax = Int.min
//    arr.forEach { num in
//        if seconMax < num {
//            seconMax = num
//        }
//        if firstMax < num {
//            seconMax = firstMax
//            firstMax = num
//        }
//    }
//    return (firstMax, seconMax)
//}
//
//print(getMax([-2,-6,-23,-68, -9, -10, -7 ,-100, -200]))

//Given an array, rotate the array to the right by k steps, where k is non-negative
//
//Examples :
//    [1,2,3,4,5,6,7], k = 3
//    [4,5 , 6, 1 ,2 ,3 ,4]
//    Output: [5,6,7,1,2,3,4]
//
//    [-1,-100,3,99], k = 2
//    Output: [3,99,-1,-100]



//func rotateArray(_ arr:[Int], K: Int) -> [Int] {
//    var curArray = arr
//    let loopLimit = K % arr.count
////    for _ in 0..<loopLimit {
////        var temp = 0
////        curArray = curArray.compactMap({ num -> Int in
////            let res = temp
////            temp = num
////            return res
////        })
////        curArray[0] = temp
////    }
//    for (index, value) in arr.enumerated() {
//        let indx = (index + loopLimit) % arr.count
//        curArray[indx] = value
//    }
//    return curArray
// }
//
//print(rotateArray([1,2,3,4,5,6,7], K: 50))
//
//print(rotateArray([-1,-100,3,99], K: 2))


//class Solution {
//
////    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
////        guard amount != 0 else {return 0}
////        var dp: [Int] = Array(repeating: Int.max-1, count: amount+1)
////        coins.forEach{ num -> Void in
//////            print(dp)
////            dp = dp.reduce([Int](), { (partialResult, value) in
////                let tAmnt = partialResult.count
////                var res = partialResult
//////                print(res, tAmnt, value, num)
////                if num > tAmnt {
////                    res.append(value)
////                } else if num == tAmnt {
////                    res.append(1)
////                } else {
////                    let curVal = 1 + min(dp[tAmnt - num], partialResult[tAmnt - num])
////                    res.append(curVal < value ? curVal : value)
////                }
////                return res
////            })
////        }
////        return dp[amount] >= (Int.max - 1) ? -1 : dp[amount]
////    }
//
//    func coinChange(_ arr:[Int], _ amount: Int) -> Int {
//        guard amount != 0 else {return 0}
//        var dp: [Int] = [Int](repeating: Int.max-1, count: amount)
//        for coin in arr {
//            autoreleasepool { () -> () in
//                var temp = [Int]()
//                for (index, value) in dp.enumerated() {
//                    let amnt = index + 1
//                    if amnt < coin {
//                        temp.append(value)
//                    } else if amnt == coin {
//                        temp.append(1)
//                    } else {
//                        let redAmntIdx = index - coin
//                        if redAmntIdx < 0 {
//                            temp.append(value)
//                        } else {
//                            let curValue = 1 + min(dp[redAmntIdx], temp[redAmntIdx])
//                            temp.append(min(curValue, value))
//                        }
//                    }
//                }
//                dp = temp
//            }
//        }
//        return dp[amount - 1] >= (Int.max - 1) ? -1 : dp[amount - 1]
//    }
//}
//
//Solution().coinChange([1,2,5], 11)
//Solution().coinChange([2], 3)
//Solution().coinChange([2,7,5], 9)
//Solution().coinChange([333,243,214,132,281], 9334)
//
//class A {
//    var num: Int
//    init(num: Int) {
//        self.num = num
//    }
//}
//
//let a = A(num: 5)
//
//let b = A(num: 5)
//
//print(a === b)
//
//
//let clos : () -> Void = {
//    print("Closure")
//}
//
//let closB = clos
//
//print(a === UIView(frame: .zero))
//
////print(a === clos)


//let sq = DispatchQueue.init(label: "serial")
//
//func test() {
//    DispatchQueue.main.sync {
//        print("a")
//        DispatchQueue.main.sync {
//            print("b")
//        }
//    }
//    print("c")
//}

//class A {
//    var num = 10
//}
//
//let a = A()
//print(a.num)
//func changeA(_ b: A) {
//    print(b.num)
//    b.num = 30
//    print(b.num)
//}
//changeA(a)
//print(a.num)



//
//
//struct Tracking: Decodable {
//    var key: String
//}
//
//struct User: Decodable {
//    var name: String!
//    var email: String?
//    var phone: String?
//
//}
//

//class Solution {
//    func maxProduct(_ nums: [Int]) -> Int {
//        var maxAns: Int = nums[0]
//        var maxTillHere: Int = nums[0]
//        var minTillHere: Int = nums[0]
//
//        for index in 1..<nums.count {
//            autoreleasepool(invoking: {() -> () in
//                let temp = max(minTillHere * nums[index], maxTillHere * nums[index], nums[index])
//                minTillHere = min(minTillHere * nums[index], maxTillHere * nums[index], nums[index])
//                maxTillHere = temp
//                if maxAns < maxTillHere {
//                    maxAns = maxTillHere
//                }
//            })
//        }
//        return maxAns
//    }
//}
//Solution().maxProduct([2,3,-2,4])
//Solution().maxProduct([-2,-8,-1,])
//
//public class ListNode {
//    public var val: Int
//    public var next: ListNode?
//    public init() { self.val = 0; self.next = nil; }
//    public init(_ val: Int) { self.val = val; self.next = nil; }
//    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
//}
//
//class Solution {
//    var carry: Int = 0
//    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
//        guard l1 != nil || l2 != nil || carry != 0 else {return nil}
//        let first: Int = l1?.val ?? 0
//        let second: Int = l2?.val ?? 0
//        let sum: Int = first + second + carry
//        carry = sum / 10
//        let ans = ListNode(sum % 10)
//        ans.next = addTwoNumbers(l1?.next, l2?.next)
//        return ans
//    }
//}



//protocol Employee {
//    var id: String {get set}
//    var name: String {get set}
//    var salaray: Double {get set}
//    var department: Department {get set}
//}
//
//enum Department {
//    case hr(id: String)
//    case engineering(id: String)
//    case finance(id: String)
//}
//
//extension Array where Element : Employee {
//    func getHighest() -> Double {
//        reduce(0.0) { partialResult, value in
//            return partialResult > value.salaray ? partialResult : value.salaray
//        }
//    }
//
//    func getHighestSalary(for department: Department) -> Double {
//        self.filter({ employee in
//            employee.department == department
//        })
//    }
//}


//class A {
//    var b : B!
//
//    init() {
//
//    }
//}
//
//struct B {
//    var a : A!
//}
//
//
//var objA: A? = A()
//var objB: B = B()
//
//objA?.b = objB
//objB.a = objA
//
//print(#line, objA)
//print(#line,objB)
//print(#line,objA?.b)
//print(#line,objA?.b.a)
//
//
//objA = nil
//
//print(#line,objB)
////print(#line,objB?.a)
////print(#line,objB?.a.b)

//class Solution {
//    func lengthOfLIS(_ nums: [Int]) -> Int {
//        var dp:[Int] = [0]
//        var maxLen: Int = 0
//        for index in 1..<nums.count {
//            let val = nums[index]
//            if nums[dp[maxLen]] < val {
//                maxLen += 1
//                dp.append(index)
//            } else if nums[dp[0]] > val {
//                dp[0] = index
//            } else {
//                let indx = binarySearch(nums, dp, 0, maxLen, val)
//                if indx >= 0 {
//                    dp[indx] = index
//                }
//            }
//        }
//        return maxLen + 1
//    }
//
//    private func binarySearch(_ nums:[Int], _ dp:[Int], _ start:Int = 0, _ end:Int, _ target:Int) -> Int {
//        guard start <= end else {return start}
//        let mid = (start &+ end) >> 1
//        let val = nums[dp[mid]]
//        if val > target {
//            return binarySearch(nums, dp, start, mid - 1, target)
//        }
//        if val < target {
//            return binarySearch(nums, dp, mid + 1, end, target)
//        }
//        return -1
//    }
//}
//
//Solution().lengthOfLIS([10,9,2,5,3,7,101,18])

//class Person {
//    let name: String
//    init(name: String) { self.name = name }
//    var apartment: Apartment?
//    deinit { print("\(name) is being deinitialized") }
//}
//
//class Apartment {
//    let unit: String
//    init(unit: String) { self.unit = unit }
//    weak var tenant: Person?
//    deinit { print("Apartment \(unit) is being deinitialized") }
//}
//
//var john: Person?
//var unit4A: Apartment?
//
//john = Person(name: "John Appleseed")
//unit4A = Apartment(unit: "4A")
//
//john!.apartment = unit4A
//unit4A!.tenant = john
//
//
//john = nil
////print(unit4A?.unit)

//print(unit4A?.tenant?.name)


//let arr: [Int] = [1,2,4,5,7,3]
//
//let sum : Int = arr.reduce(0, +)
//
//func customReduce(_ arr: [Int], _ transform: (Int, Int) throws -> Int) rethrows -> Int {
//    var res = 0
//    for value in arr {
//        do {
//         res =  transform(res, value)
//        } catch let error {
//            throw error
//        }
//    }
//    return res
//}
//
//try? customReduce(arr, +)

//class Solution {
//    func longestPalindrome(_ s: String) -> String {
//        var dp:[[Bool]] = []
//        let temp:[Bool] =  [true]
//        let str: [Character] = Array(s)
//        for _ in 0..<s.count {
//            dp.append(temp)
//        }
//        var startIndex = 0
//        var endIndex = 0
//        for k in 1..<str.count {
////            print()
//            for (i,j) in zip(0..<(str.count-k), k..<str.count) {
////                print("k =",k,"i = ",i,"j =",j," dp =",dp," str =",str)
//                if str[i] == str[j] {
//                    let rt = (i+1) > (j-1)
//                    let val = rt || dp[i+1][k-2]
//                    dp[i].append(val)
//                    if val {
//                        startIndex = i
//                        endIndex = j
//                    }
//                } else {
//                    dp[i].append(false)
//                }
//            }
//        }
//        return str[startIndex...endIndex].reduce("", {"\($0)\($1)"})
//    }
//}
//Solution().longestPalindrome("babad")
//

//class TrieNode {
//    var isEnd = false
//    var childs:[TrieNode?] = Array(repeating: nil, count: 26)
//}
//
//final class Solution {
//    var trie: TrieNode!
//    let aAsciiValue = ("a" as Character).asciiValue
//    var dp : [[Bool?]]!
//    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
//        trie = TrieNode()
//        dp = Array(repeating: Array(repeating: nil, count: s.count), count: s.count)
//        insert(wordDict)
//        let charArr = Array(s)
//        return solve(charArr, currIndex: 0)
//    }
//
//    private func solve(_ arr: [String.Element], currIndex: Int) -> Bool {
//        if currIndex > arr.count {
//            return true
//        }
//        var tempTrie = trie
//        for index in currIndex..<arr.count {
//            if dp[currIndex][index] != nil {
//                return dp[currIndex][index]!
//            }
//            let charIdx: Int = Int(arr[index].asciiValue! - aAsciiValue!)
//            if let child = tempTrie?.childs[charIdx] {
//                if child.isEnd {
//                    dp[currIndex][index] = true
//                    let val: Bool = solve(arr, currIndex: index+1)
//                    if val {
//                        return true
//                    }
//                } else {
//                    dp[currIndex][index] = false
//                }
//                tempTrie = child
//            } else {
//                return false
//            }
//        }
//        return tempTrie?.isEnd ?? false
//    }
//
//    private func insert(_ wordDict: [String]) {
//        var tempTrie: TrieNode?
//        wordDict.forEach { word in
//            tempTrie = trie
//            word.forEach { char in
//                let index: Int = Int(char.asciiValue! - aAsciiValue!)
//                if let child = tempTrie?.childs[index] {
//                    tempTrie = child
//                } else {
//                    let child = TrieNode()
//                    tempTrie?.childs[index] = child
//                    tempTrie = child
//                }
//            }
//            tempTrie?.isEnd = true
//        }
//    }
//}
//Solution().wordBreak("aaaaaaab",["aaaa","aa","a","aaa"])
//Solution().wordBreak("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab", ["a","aa","aaa","aaaa","aaaaa","aaaaaa","aaaaaaa","aaaaaaaa","aaaaaaaaa","aaaaaaaaaa"])
//Solution().wordBreak("leetcode", ["leet", "code"])

//@propertyWrapper
//struct SmallNumber {
//    private var maximum: Int
//    private var number: Int
//
//    var wrappedValue: Int {
//        get { return number }
//        set { number = min(newValue, maximum) }
//    }
//
//    init() {
//        maximum = 12
//        number = 0
//    }
//    init(vakue: Int) {
//        maximum = 12
//        number = min(vakue, maximum)
//    }
//    init(wrappedValue: Int) {
//        maximum = 12
//        number = min(wrappedValue, maximum)
//    }
//    init(wrappedValue: Int, maximum: Int) {
//        self.maximum = maximum
//        number = min(wrappedValue, maximum)
//    }
//}
//
//struct ZeroRectangle {
//    @SmallNumber var height: Int
//    @SmallNumber var width: Int
//}
//
//var zeroRectangle = ZeroRectangle()
//print(zeroRectangle.height, zeroRectangle.width)
//
//struct UnitRectangle {
//    @SmallNumber(vakue: 2) var height: Int
//    @SmallNumber var width: Int = 1
//}
//
//var unitRectangle = UnitRectangle()
//print(unitRectangle.height, unitRectangle.width)
//
//struct NarrowRectangle {
//    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
//    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
//}
//
//var narrowRectangle = NarrowRectangle()
//print(narrowRectangle.height, narrowRectangle.width)
//// Prints "2 3"
//
//narrowRectangle.height = 100
//narrowRectangle.width = 100
//print(narrowRectangle.height, narrowRectangle.width)
//// Prints "5 4"
//
//struct MixedRectangle {
//    @SmallNumber var height: Int = 1
//    @SmallNumber(maximum: 9) var width: Int = 2
//}
//
//var mixedRectangle = MixedRectangle()
//print(mixedRectangle.height)
//// Prints "1"
//
//mixedRectangle.height = 20
//print(mixedRectangle.height)
//// Prints "12"
//
//class A {
//
//}
//
//extension A {
//     @SmallNumber dynamic var extendedProp: Int
//}

//enum A {
//    case a
//    case b
//
//    var computedProp : Int {
//        return 10
//    }
//}
//var enumA = A.a
//
//print(enumA.computedProp)

//class Solution {
//    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
//        var dp : [Int] = [1]
//
////        for sum in 1...target {
////            var tempRes = 0
////            var index = 0
////            while sum - nums[index] >= 0 {
//////                tempRes += dp[sum - nums[index]]
////                index += 1
////            }
////            dp.append(tempRes)
////        }
//
//        for sum in 1...target {
//            var tempRes = 0
//            for num in nums {
//                if sum >= num {
//                    tempRes += dp[sum-num]
//                }
//            }
//            dp.append(tempRes)
//        }
//
//        return dp[target]
//    }
//}
//
////Solution().combinationSum4([9], 3)
////Solution().combinationSum4([1,2,3], 4)
//Solution().combinationSum4([10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480,490,500,510,520,530,540,550,560,570,580,590,600,610,620,630,640,650,660,670,680,690,700,710,720,730,740,750,760,770,780,790,800,810,820,830,840,850,860,870,880,890,900,910,920,930,940,950,960,970,980,990,111], 999)

//class Solution {
//    private final var dp:[Int]!
//    func numDecodings(_ s: String) -> Int {
//        dp = Array(repeating: -1, count: s.count)
//        return solve(s, index: s.startIndex, curIndex: 0)
//    }
//
//    private final func solve(_ s: String, index: String.Index, curIndex: Int) -> Int {
//        guard s.endIndex > index else {
//            return 1
//        }
//        guard dp[curIndex] == -1 else {
//            return dp[curIndex]
//        }
//
//        guard s[index] != "0" else {
//            dp[curIndex] = 0
//            return 0
//        }
//
//        let nextIndex = s.index(after: index)
//
//        dp[curIndex] = solve(s, index: nextIndex, curIndex: curIndex + 1)
//
//        if nextIndex < s.endIndex && s[index...nextIndex] <= "26" {
//            dp[curIndex] += solve(s, index: s.index(after: nextIndex), curIndex: curIndex + 2)
//        }
//
//        return dp[curIndex]
//    }
//
//    final private func answer(_ s: String, index: String.Index) {
//        var cache: [Int] = Array(repeating: 0, count: s.count)
//        var index: Int = 0
//
//        for indx in stride(from: s.count-1, through: 0, by: -1)  {
//
//        }
//    }
//}
//
//Solution().numDecodings("11106")
//Solution().numDecodings("12")
//Solution().numDecodings("226")
//Solution().numDecodings("06")
//Solution().numDecodings("227")

//class Solution {
//    func uniquePaths(_ m: Int, _ n: Int) -> Int {
//        var dp: [Int] = Array(repeating: 1, count: n)
//        for row in stride(from: m-2, through: 0, by: -1) {
//            for col in stride(from: n-2, through: 0, by: -1) {
//                dp[col] = dp[col] + dp[col + 1]
//            }
//        }
//        return dp[0]
//    }
//}
//
//Solution().uniquePaths(3, 7)
//Solution().uniquePaths(3, 2)

// [-2,-1,1,2, -3, 5, 11]
//func getRemainingAsteroids(_ arr: [Int]) -> [Int] {
//    var resArr: [Int] = []
//    var index  = 0
//    while index < arr.count - 1 {
//        print("index = ", index, "resArr = ", resArr)
////        if arr[index] >= 0 && arr[index + 1] < 0 {
////            let pos = arr[index]
////            let neg = arr[index + 1] * -1
////            if pos == neg {
////                index += 1
////                continue
////            }
////            if pos > neg {
////                resArr.append(pos)
////            } else {
//////                var canNegAdded = true
////                while let lastVal = resArr.last, lastVal > 0, lastVal < neg {
////                    resArr.removeLast()
////                }
////                if resArr.last == nil || resArr.last! < 0 {
////                    resArr.append(-1 * neg)
////                }
////                index += 1
////            }
////        } else {
////            resArr.append(arr[index])
////        }
////        index += 1
//        let curVal = arr[index]
//        if curVal < 0 {
//            let neg = -1 * curVal
//            while let lastVal = resArr.last, lastVal > 0, lastVal <= neg {
//                resArr.removeLast()
//            }
//            if resArr.last == nil || resArr.last! < 0 {
//                resArr.append(curVal)
//            }
//        } else {
//            while let lastVal = resArr.last, lastVal < 0, (lastVal * -1) <= curVal {
//                resArr.removeLast()
//            }
//            if resArr.last == nil || resArr.last! > 0 {
//                resArr.append(curVal)
//            }
//        }
//        index += 1
//    }
//    if arr[arr.count - 1] > 0 {
//        resArr.append(arr[arr.count - 1])
//    }
//    return resArr
//}
//getRemainingAsteroids([-4, 10,-5])

class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        var maxReachable: Int = 0
        for (index, value) in nums.enumerated() {
            guard maxReachable >= index else {
                return false
            }
            maxReachable = max(maxReachable, index+value)
        }
        return maxReachable >= (nums.count - 1)
    }
}
Solution().canJump([3,2,1,0,4])
Solution().canJump([2,3,1,1,4])
