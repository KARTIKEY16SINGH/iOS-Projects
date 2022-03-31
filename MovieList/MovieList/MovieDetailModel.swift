//
//  MovieDetailModel.swift
//  MovieList
//
//  Created by Iron Man on 21/05/21.
//

import Foundation

struct MovieDetailMode : Decodable {
    let title : String
    let imdbID : String
    let imageURL : String
    let year : String
    let casts : String
    let plot : String
    
    enum CodingKeys : String, CodingKey {
        case title = "Title"
        case imdbID
        case imageURL = "Poster"
        case year = "Year"
        case casts = "Actors"
        case plot = "Plot"
    }
}
