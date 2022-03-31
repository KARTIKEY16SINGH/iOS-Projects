import UIKit

//var greeting = "Hello, playground"

func getRandomInt(start: Int, end: Int) -> Int {
    var res: Int!
    for _ in start...Int.random(in: (start+1)...(end+1)) {
        res = Int.random(in: start...end)
    }
    return res
}

getRandomInt(start: 1, end: 11)
