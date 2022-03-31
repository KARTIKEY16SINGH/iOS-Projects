import UIKit


//ABCDEFDEFDEF

class Node<T: Equatable> {
    let val: T
    var next: Node?
    
    init(value: T) {
        val = value
    }
}


func flatLinkedList<T>(head: Node<T>?, slow: Node<T>?, fast: Node<T>?) -> Node<T>? {
    guard var head = head, var slow = slow, var fast = fast  else {return head}
    print(slow.val, fast.val)
    if slow.val == fast.val {
        var start = head
        fast = fast.next!
        while start.val != fast.val {
            start = start.next!
            fast = fast.next!
        }
        slow = start
        while start.val != slow.next!.val {
            slow = slow.next!
        }
        slow.next = nil
        return head
    } else {
        let nslow: Node<T>? = slow.next
        let nfast: Node<T>? = fast.next?.next
        return flatLinkedList(head: head, slow: nslow, fast: nfast)
//        return slow
    }
}

let A = Node<String>(value: "A")
let B = Node<String>(value: "B")
let C = Node<String>(value: "C")
let D = Node<String>(value: "D")
let E = Node<String>(value: "E")
let F = Node<String>(value: "F")
let G = Node<String>(value: "G")
let H = Node<String>(value: "H")
let I = Node<String>(value: "I")
let J = Node<String>(value: "J")

A.next = B
B.next = C
C.next = D
D.next = E
E.next = F
F.next = G
G.next = H

var res = flatLinkedList(head: A, slow: A, fast: A.next)
while res != nil {
    print(res?.val, "->")
    res = res?.next
}



//enum Keys {
//    case king,
//    case queen,
//    case horse,
//    case elephant
//}
//
//struct King: Key {
//
//}
//
//protocol Key {
//    var name
//    var curPost : nil
//    func validate
//}
//
//protocol Moves{
//    func validateModes(tartpos: Int, endPos: Int) --> Bool
//}
//
//protocol ChessP {
//    var board: [Keys?]
//    func validateMoVe(Key: Keys, startpos: Int, endPos: Int) -> Bool
//    func start()
//    func end()
//    func updateKeyPos(key: Keys, startPos: Int, endPos:Int, delete: Bool)
//}
