import UIKit
import Foundation
import SwiftUI

//protocol A {
//    func greet()
//}
//extension A {
//    func greet() { print("A default") }
//}
//
//protocol B: A { }
//extension B {
//    func greet() { print("B default") }
//}
//
//struct S: B { }
//
//let a: A = S()
//a.greet()   // "A default"
//
//let b: B = S()
//b.greet()   // "B default"


//protocol A {
//    func greet()
//}
//extension A {
//    func greet() { print("A default") }
//}
//
//protocol B {
//    func greet()
//}
//
//extension B {
//    func greet() { print("B default") }
//}

//struct S: A, B {
//    func greet() {
//        print("struct geet")
//    }
//}


protocol Drawable {
    func draw()
}

struct Circle: Drawable {
    func draw() {
        print("I am circle")
    }
}

struct Square: Drawable {
    func draw() {
        print("I am square")
    }
}

extension Square {
    var drawable: some Drawable { Circle() }
}


protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
       var result: [String] = []
       for length in 1...size {
           result.append(String(repeating: "*", count: length))
       }
       return result.joined(separator: "\n")
    }
}
let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

func protoFlip<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }


    return FlippedShape(shape: shape)
}

func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}

func concreteOpaque() -> some Shape {
    return Triangle(size: 4)
}

//let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(protoFlip(smallTriangle))

//let flippedTriangle = flip(flip(smallTriangle) as! Shape)
//print(flippedTriangle.draw())

//let casting = concreteOpaque() as? Triangle
//protoFlippedTriangle == sameThing

sameThing.draw()



let expected = [[-15,69],[-50,-67],[74,-114],[174,121],[96,205],[-148,183],[23,-236],[-235,70],[105,224],[121,-216],[-248,75],[-18,262],[142,223],[12,277],[-190,-236],[183,-247],[-306,-85],[148,284],[-326,46],[-74,328],[-78,-340],[356,37],[357,-68],[-311,211],[-97,377],[286,-273],[395,-30],[-251,310],[-344,204],[-188,359],[-40,414],[-410,89],[-137,-397],[8,-420],[203,371],[-62,426],[417,111],[337,-282],[434,89],[455,6],[445,-98],[34,-460],[454,115],[-260,-390],[-468,34],[-202,-434],[-65,475],[124,-469],[405,286],[-215,-463],[528,-28],[-86,524],[-76,-532],[70,545],[434,-354],[-134,551],[336,-467],[-563,-166],[-537,248],[247,552],[-452,408],[603,-86],[-509,361],[-473,-409],[-539,332],[408,-486],[438,471],[297,576],[578,310],[-553,-369],[507,432],[666,-97],[-181,650],[571,369],[-631,-255],[-163,662],[-220,-653],[674,178],[-176,-677],[704,40],[433,-558],[-450,-552],[381,605],[34,719],[-414,589],[553,-470],[-169,709],[-679,-314],[595,466],[516,579],[726,-296],[-393,684],[-671,424],[787,-108],[-464,-648],[389,697],[398,697],[-668,-463],[814,-30],[-698,-424],[-749,-329],[799,201],[333,-762],[-130,829],[-88,-837],[824,-182],[845,20],[40,-847],[672,518],[23,851],[-186,-838],[-810,287],[7,-865],[-651,-570],[-132,-857],[-798,-345],[869,-100],[-378,792],[443,-764],[-764,-452],[274,-847],[448,-770],[807,-389],[-43,897],[-798,-414],[-453,785]]

let output = [[807,-389],[274,-847],[448,-770],[-798,-345],[-378,792],[443,-764],[-186,-838],[-130,829],[-132,-857],[7,-865],[672,518],[-810,287],[-651,-570],[333,-762],[-749,-329],[704,40],[799,201],[845,20],[-169,709],[-724,608],[595,466],[-668,-463],[824,-182],[666,-97],[-393,684],[-86,524],[40,-847],[-898,437],[438,471],[398,697],[726,-296],[507,432],[-163,662],[-220,-653],[-698,-424],[-537,248],[-88,-837],[-181,650],[336,-467],[381,605],[389,697],[454,115],[-414,589],[-134,551],[-539,332],[-553,-369],[-464,-648],[-97,377],[-509,361],[434,-354],[433,-558],[203,371],[405,286],[603,-86],[578,310],[814,-30],[-764,-452],[286,-273],[-631,-255],[530,751],[674,178],[-679,-314],[553,-470],[297,576],[-344,204],[-148,183],[23,851],[-137,-397],[-260,-390],[121,-216],[516,579],[-40,414],[-76,-532],[-563,-166],[-326,46],[-188,359],[-410,89],[434,89],[-62,426],[124,-469],[787,-108],[571,369],[445,-98],[-18,262],[395,-30],[-450,-552],[-473,-409],[8,-420],[337,-282],[528,-28],[869,-100],[408,-486],[142,223],[34,719],[417,111],[74,-114],[-248,75],[-311,211],[-74,328],[-235,70],[-306,-85],[247,552],[174,121],[357,-68],[12,277],[-251,310],[455,6],[-15,69],[-452,408],[105,224],[34,-460],[70,545],[-671,424],[356,37],[-65,475],[-78,-340],[96,205],[183,-247],[-202,-434],[-50,-67],[-176,-677],[-190,-236],[-215,-463],[-468,34],[148,284],[23,-236]]


@inline(__always)
private func distanceFromOrigin(_ point: [Int]?) -> Int {
    guard let point else { return Int.max }
    return (point[0] * point[0]) + (point[1] * point[1])
}

let comparator: ([Int], [Int]) -> Bool = { pointOne, pointTwo in
    let distanceOne = distanceFromOrigin(pointOne)
    let distanceTwo = distanceFromOrigin(pointTwo)
    return distanceOne > distanceTwo
}

let sortedExpected = expected.sorted(by: comparator)
let sortedOutput = output.sorted(by: comparator)

print(sortedExpected == sortedOutput)

var missing: [[Int]] = []

for point in sortedExpected {
    if !sortedOutput.contains(point) {
        missing.append(point)
    }
}

print(missing)

func modifyTwice(_ value: inout Int, by modifier: (inout Int) -> ()) {
    modifier(&value)
    modifier(&value)
}

var count = 1
//modifyTwice(&count) { $0 += count }   // ❌ This violates exclusivity

func add(_ x: inout Int, _ y: Int) {
    x += x
}

var n = 5
add(&n, n)

print(n)

