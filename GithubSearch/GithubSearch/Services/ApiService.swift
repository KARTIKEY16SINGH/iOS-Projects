//
//  ApiService.swift
//  GithubSearch
//
//  Created by Iron Man on 05/11/25.
//

import Foundation

protocol ApiServicable {
    func get<T: Decodable>(request: ApiRequest, completionHandler: @escaping (Result<T, ApiError>) -> Void) -> URLSessionDataTask?
}

struct ApiRequest {
    let path: String
    let queryParams: [String: Any]
}

enum ApiError: Error {
    case invalidUrl(String)
    case parseError(Error)
    case networkError(Error)
    case serverError(status: Int?)
    case invalidDataReceived
}

final class ApiService: ApiServicable {
    private let urlSession: URLSession
    private let host: String
    
    init(urlSession: URLSession = URLSession.shared, host : String) {
        self.urlSession = urlSession
        self.host = host
    }
    
    func get<T: Decodable>(request: ApiRequest, completionHandler: @escaping (Result<T, ApiError>) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: host + request.path) else {
            completionHandler(.failure(.invalidUrl(host + request.path)))
            return nil
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error { return completionHandler(.failure(.networkError(error)))}
            guard let status = response as? HTTPURLResponse, (200..<300).contains(status.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                return completionHandler(.failure(.serverError(status: statusCode)))
            }
            
            guard let data else {
                return completionHandler(.failure(.invalidDataReceived))
            }
            
            do {
                let parsedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(parsedData))
            } catch {
                completionHandler(.failure(.parseError(error)))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
