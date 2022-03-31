//
//  NewsModel.swift
//  Dunzo
//
//  Created by Iron Man on 16/03/22.
//

import Foundation

struct NewsModel: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]
}


struct Article: Decodable {
    var title: String?
    var description: String?
    var content: String?
    var urlToImage: String?
}
