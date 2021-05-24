//
//  Cache.swift
//  ImageSearch
//
//  Created by Iron Man on 18/05/21.
//

import Foundation

class Cache<T:Hashable, E> {
    var dic = [T:[E]]()
    
    func add(_ key: T, value : E) {
//        print("[Cache] Add dic = \(dic)")
        if let _ = dic[key] {
            dic[key]!.append(value)
        } else {
            dic[key] = [value]
        }
    }
    
    func get(_ key : T) -> [E]? {
//        print("[Cache] Get dic = \(dic)")
        return dic[key]
    }
}
