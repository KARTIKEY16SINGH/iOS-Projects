//
//  FlickerPage.swift
//  ImageSearch
//
//  Created by Iron Man on 18/05/21.
//

import Foundation

/*
 {"photos":{"page":1,"pages":3659,"perpage":100,"total":365824,"photo":
 */
struct FlickerPage : Decodable {
    let photos : Photos
}

struct Photos : Decodable {
    let page : Int
    let pages : Int
    let perPage : Int
    let totalPhoto : Int
    let photo : [Photo]
    
    enum CodingKeys : String, CodingKey {
        case page, pages
        case perPage = "perpage"
        case totalPhoto = "total"
        case photo
    }
}
