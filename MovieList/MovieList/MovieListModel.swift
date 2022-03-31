//
//  MovieListModel.swift
//  MovieList
//
//  Created by Iron Man on 21/05/21.
//

import Foundation

/*
 {"Title":"The Avenger","Year":"1960","imdbID":"tt0054257","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BNzU5YzM3MmEtNTE2MS00MzVjLWI5Y2EtNGU3M2YwMGYzMGQ0XkEyXkFqcGdeQXVyMDExMzA0Mw@@._V1_SX300.jpg"}
 */

struct MovieListModel : Decodable {
    let title : String
    let imdbID : String
    let imageURL : String
    
    enum CodingKeys : String, CodingKey {
        case title = "Title"
        case imdbID = "imdbID"
        case imageURL = "Poster"
    }
}

struct MovieSearhModel : Decodable {
    let search : [MovieListModel]?
    let response : String
    let error : String?
    
    enum CodingKeys : String, CodingKey {
        case search = "Search"
        case response = "Response"
        case error = "Error"
    }
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.search = try? container.decode([MovieListModel].self, forKey: .search)
        self.response = try container.decode(String.self, forKey: .response)
        self.error = try? container.decode(String.self, forKey: .error)
    }
}
