//
//  DetailManager.swift
//  MovieList
//
//  Created by Iron Man on 21/05/21.
//

import Foundation

final class DetailManager {
    static let shared = DetailManager()
    
    private init() {}
    
    var imdbID = ""
    
    func getDetails(completionHandler : @escaping (MovieDetailMode)->()) {
        NetworkUtility.getData(fromUrl: getURL(), decodeType: MovieDetailMode.self, completionHandler: completionHandler)
    }
    
    func getImage(url : String, completionHandler : @escaping (Data) -> ()) {
        NetworkUtility.getImageData(fromURL: URL(string: url)!, completionHandler: completionHandler)
    }
    
    private func getURL() -> URL {
        let url = "https://www.omdbapi.com/?i=\(imdbID)&apikey=dcc8fcb2"
        return URL(string: url)!
    }
}
