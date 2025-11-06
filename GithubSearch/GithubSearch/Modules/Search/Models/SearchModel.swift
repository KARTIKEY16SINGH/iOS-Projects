//
//  SearchModel.swift
//  GithubSearch
//
//  Created by Iron Man on 05/11/25.
//

import Foundation

struct SearchModel: Decodable, Equatable {
    var items: [SearchItem] = []
}

struct SearchItem: Decodable, Equatable {
    let login: String
    let url: String
    let avatarUrl: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case url
        case avatarUrl = "avatar_url"
        case id
    }
}
