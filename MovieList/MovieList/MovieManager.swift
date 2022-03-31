//
//  MovieManager.swift
//  MovieList
//
//  Created by Iron Man on 21/05/21.
//

import Foundation

final class MovieManager {
    static let shared = MovieManager()
    private init(){}
//    var sechText
//    var currPage
    func searchMovie(text : String, completionHandler : @escaping (MovieSearhModel) -> ()) {
        NetworkUtility.getData(fromUrl: getMovieURL(text: text), decodeType: MovieSearhModel.self, completionHandler: completionHandler)
    }
    
    func getImage(url : String, completionHandler : @escaping (Data) -> ()) {
        NetworkUtility.getImageData(fromURL: URL(string: url)!, completionHandler: completionHandler)
    }
    
    func setIMDB(_ id: String) {
        DetailManager.shared.imdbID = id
    }
    
    private func getMovieURL(text : String) -> URL {
        let url = "https://www.omdbapi.com/?apikey=dcc8fcb2&s=\(text)&page=1"
        return URL(string: url)!
    }
}
