//
//  ApiService.swift
//  GithubSearch
//
//  Created by Iron Man on 05/11/25.
//

final class ApiService {
    
    func get<Response: Decodable>(path: String, queries: [String: Any], responseType: Response.Type, completionHandler: @escaping(Result<Response, Error>) -> Void) {
        
    }
}
