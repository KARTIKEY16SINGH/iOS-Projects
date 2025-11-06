import UIKit

//let primeNumber = 17
//let m = 6
//var Hpm : [Int] = []
//
//for a in 1..<primeNumber {
//    for b in 0..<primeNumber {
//        let modP = a
//    }
//}


//let s = "ab#c"
//let t = "ad#c"
//
//var r : [Character] = []
//
//for c in s {
//    if c == "#" {
//        r.removeLast()
//    } else {
//        r.append(c)
//    }
//}
//
//
////for c in t {
////    guard  c != "#" else {
////        !finalT.isEmpty {
////            finalT.removeLast()
////        }
////    }
////    finalT.append(c)
////}
//
//r


var dishes = ["pizza", "tacos", "burger", "waffels", "pasta"]

var randomIndex = 0

for dish in dishes {
    randomIndex = Int.random(in: 0..<dishes.count)
    print(randomIndex)
}

dishes[randomIndex]
