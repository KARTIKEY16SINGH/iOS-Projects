//
//  Photo.swift
//  ImageSearch
//
//  Created by Iron Man on 18/05/21.
//

import Foundation


/*
 {"id":"51188267730","owner":"32279709@N02","secret":"75416d90e5","server":"65535","farm":66,"title":"Marcianos en Barcelona","ispublic":1,"isfriend":0,"isfamily":0}
 */

struct Photo : Decodable {
    let id : String
    let owner : String
    let secret : String
    let server : String
    let farm : Int
}

extension Photo : Hashable {}

