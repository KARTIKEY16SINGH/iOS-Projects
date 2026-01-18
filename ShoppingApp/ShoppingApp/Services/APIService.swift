//
//  APIService.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//

import Foundation

protocol ApiServicable {
    func fetch<T: Decodable>(url: String, type: T.Type, completionHandler: @escaping (Result<T, ApiError>) -> Void)
}

enum ApiError: Error {
    case networkError
    case invalidUrl
    case parseError
    case responseError
}

struct APIService: ApiServicable {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Decodable>(url: String, type: T.Type, completionHandler: @escaping (Result<T, ApiError>) -> Void) {
        guard let requestUrl = URL(string: url) else {
            return completionHandler(.failure(.invalidUrl))
        }
        
        urlSession.dataTask(with: URLRequest(url: requestUrl)) { data, response, error in
            if let error {
                return completionHandler(.failure(.networkError))
            }
            guard let data else {
                return completionHandler(.failure(.responseError))
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(result))
            } catch {
                debugPrint("ApiService parse Error - \(error)")
                completionHandler(.failure(.parseError))
            }
        }.resume()
    }
}
