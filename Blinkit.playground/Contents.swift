import UIKit

//List Of cart Items
/*
 
 list of items
 price of item
 checkout & payment
 
 
 */

//let group = DispatchGroup()
//
//group.enter()
//fetchCardDeatail() {
//    //
//    group.leave()
//}
//
//group.enter()
//fetchCardDeatail() {
//    //
//    group.leave()
//}
//
//group.notify(queue: .main, execute: {
//    // code to stop loader
//})

//struct GenricID {
//    var value:
//    init(_ stringValue: String) {
//    }
//    init(_ iniValue: Int) {}
////    var stringValue
//}

//struct CartItem: Decodable {
//// @GenericID   var cardId:
//
////    struct DynamicKey: CodingKey {
////        var stringValue: String
////
////        init?(stringValue: String) {
////            self.stringValue = stringValue
////        }
////
////        var intValue: Int?
////
////        init?(intValue: Int) {
////            self.intValue = intValue
////            self.stringValue = ""
////        }
////
////
////    }
//
//    enum CodingKeys: String, CodingKey {
//        case cardId
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let stringValue =
//    }
//}

protocol ViewProtocol: AnyObject {
    func receivedData()
}

class ViewController : ViewProtocol {
    init() {
        
    }
    func btnTapped() {
        
    }
    func receivedData() {
        // code
    }
}

class ViewModel {
    weak var view : ViewProtocol?
//    @obseravable @dynamic var data
    func getData() {
        //Suppose data
        
        view?.receivedData()
    }
}


//enum MyOptional<T:Any> : ExpressibleByNilLiteral {
//    case none
//    case some(T)
//
//    init(rawValue: ) {
//        if rawValue == nil {
//            self = .none
//        }else {
//            self = .some(rawValue)
//        }
//    }
//}

var a: String = "aa"
     var b: String! = "bb"
     var c: String? = "cc"
print(b)
//a = nil
//Satyam Sehgal4:55 PM
b = nil
//Satyam Sehgal4:57 PM
c = nil
//a = b
//Satyam Sehgal5:00 PM
//a = c
b = c
