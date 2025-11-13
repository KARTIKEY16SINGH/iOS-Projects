//
//  ApiService.swift
//  WetherForcastSearch
//
//  Created by Iron Man on 14/11/25.
//

import Foundation

protocol ApiServicable {
    @discardableResult
    func get<T:Decodable>(request: ApiRequest, type: T.Type, completionHandler: @escaping(Result<T, ApiError>) -> Void) -> URLSessionDataTask?
}

enum ApiError: Error {
    case invalidUrl
    case networkError(Error)
    case invalidData
    case parseError
}

struct ApiRequest {
    let path: String
    let queryParams: [String: Any]
}


struct ApiService {
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = .shared
    }
    
    @discardableResult
    func get<T:Decodable>(request: ApiRequest, type: T.Type, completionHandler: @escaping(Result<T, ApiError>) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: request.path) else {
            completionHandler(.failure(.invalidUrl))
            return nil
        }
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completionHandler(.failure(.networkError(error)))
                return
            }
            
            guard let data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.parseError))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
