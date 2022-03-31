import UIKit

class AVLTree<T: Comparable> {
    class Node<T> {
        var key : T, height : Int = 1
        var left, right : Node<T>?
        
        init(_ _key: T) {
            key = _key
        }
    }
    
    private(set) var root : Node<T>?
    private(set) var size : Int = 0
    
    func insert(_ key: T) {
        root = insertUtil(key, root)
        size += 1
    }
    
    private func insertUtil(_ key: T,_ node: Node<T>?) -> Node<T> {
        guard let root = node else {
            return Node(key)
        }
        if root.key > key {
            root.left = insertUtil(key, root.left)
        } else if root.key < key {
            root.right = insertUtil(key, root.right)
        } else {
            return root
        }
        let leftHeight = getHeight(root.left)
        let rightHeight = getHeight(root.right)
        root.height = 1 + max(leftHeight, rightHeight)
        let balanceFactor = leftHeight - rightHeight
        
        if balanceFactor > 1 && root.key > key { //LL
            return rotateLL(root)
        } else if balanceFactor > 1 && root.key < key { //LR
            return rotateLR(root)
        } else if balanceFactor < -1 && root.key > key { //RL
            return rotateRL(root)
        } else if balanceFactor < -1 && root.key < key { //RR
            return rotateRR(root)
        }
        
        return root
    }
    
    func getSmallestNode(_ root: Node<T>?) -> T? {
        if root == nil {return nil}
        var node = root
        while node != nil && node?.left != nil {
            node = node?.left
        }
        return node?.key
    }
    
    func delete(_ key: T) {
        deleteUtil(key, &root)
    }
    
    private func deleteUtil(_ key: T, _ node: inout Node<T>?) -> Node<T>? {
        guard let _node = node else {return nil}
        if _node.key > key {
            _node.left = deleteUtil(key, &_node.left)
        } else if _node.key < key {
            _node.right = deleteUtil(key, &_node.right)
        } else {
            if _node.right == nil || _node.left == nil {
                var temp = _node.left
                if temp == nil {
                    temp = _node.right
                }
                node = temp
            } else {
                let temp = getSmallestNode(_node.right)
                _node.key = temp!
                _node.right = deleteUtil(temp!, &_node.right)
            }
        }
        if node == nil {return nil}
        
        let leftHeight = getHeight(_node.left)
        let rightHeight = getHeight(_node.right)
        _node.height = 1 + max(leftHeight, rightHeight)
        let balanceFactor = leftHeight - rightHeight
        
        if balanceFactor > 1 {
            if getHeight(_node.left?.left) - getHeight(_node.left?.right) >= 0 {
                return rotateLL(_node)
            }
            return rotateLR(_node)
        }
        if balanceFactor < -1 {
            if getHeight(_node.right?.left) - getHeight(_node.right?.right) <= 0 {
                return rotateRR(_node)
            }
            return rotateRL(_node)
        }
        return _node
    }
    
    private func rotateLL(_ node: Node<T>) -> Node<T> {
        let newHead = node.left
        node.left = newHead?.right
        newHead?.right = node
        node.height = 1 + max(getHeight(node.left), getHeight(node.right))
        newHead?.height = 1 + max(getHeight(newHead?.left), getHeight(newHead?.right))
        return newHead!
    }
    
    private func rotateRR(_ node: Node<T>) -> Node<T> {
        let newHead = node.right
        node.right = newHead?.left
        newHead?.left = node
        node.height = 1 + max(getHeight(node.left), getHeight(node.right))
        newHead?.height = 1 + max(getHeight(newHead?.left), getHeight(newHead?.right))
        return newHead!
    }
    
    private func rotateLR(_ node: Node<T>) -> Node<T> {
        let leftChild = node.left
        let newHead = leftChild?.right
        node.left = newHead?.right
        leftChild?.right = newHead?.left
        newHead?.left = leftChild
        newHead?.right = node
        node.height = 1 + max(getHeight(node.left), getHeight(node.right))
        leftChild?.height = 1 + max(getHeight(leftChild?.left), getHeight(leftChild?.right))
        newHead?.height = 1 + max(getHeight(newHead?.left), getHeight(newHead?.right))
        return newHead!
    }
    
    private func rotateRL(_ node: Node<T>) -> Node<T> {
        let rightChild = node.right
        let newHead = rightChild?.left
        node.right = newHead?.left
        rightChild?.left = newHead?.right
        newHead?.left = node
        newHead?.right = rightChild
        node.height = 1 + max(getHeight(node.left), getHeight(node.right))
        rightChild?.height = 1 + max(getHeight(rightChild?.left), getHeight(rightChild?.right))
        newHead?.height = 1 + max(getHeight(newHead?.left), getHeight(newHead?.right))
        return newHead!
    }
    
    func getHeight(_ node: Node<T>?) -> Int {
        guard let node = node else {return 0}
        return node.height
    }
    
    func getNearestMaximum(num: T, node: Node<T>? = nil)-> T?{
        var temp = node ?? root
        var ans: T?
        while temp != nil {
            if temp!.key >= num {
                ans = temp?.key
                temp = temp?.left
            } else {
                temp = temp?.right
            }
        }
        return ans
    }
    
    func getNearestMinimum(num: T, node: Node<T>? = nil) -> T? {
        var temp = node ?? root
        var ans: T?
        while temp != nil {
            if temp!.key <= num {
                ans = temp?.key
                temp = temp?.right
            } else {
                temp = temp?.left
            }
        }
        return ans
    }
}

let avlTree = Util()
avlTree.getNearestMaximum(num: 12)
// LL
avlTree.insert(10)
avlTree.insert(8)
avlTree.insert(7)

// RR
avlTree.insert(11)
avlTree.insert(12)
avlTree.insert(6)
class Util : AVLTree<Int> {
    
}

avlTree.getNearestMaximum(num: 13)
avlTree.getNearestMaximum(num: 12)
avlTree.getNearestMinimum(num: 10)
avlTree.getNearestMinimum(num: 1)

avlTree.delete(8)

class Solution {
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        let avl = AVLTree<Int>()
        
        for (index, item) in nums.enumerated() {
            var element = avl.getNearestMaximum(num: item)
            if let ele = element, ele - item <= t {
                return true
            }
            element = avl.getNearestMinimum(num: item)
            if let ele = element, item - ele <= t {
                return true
            }
            avl.insert(item)
            if avl.size > k {
                avl.delete(nums[index-k])
            }
        }
        
        return false
    }
}
