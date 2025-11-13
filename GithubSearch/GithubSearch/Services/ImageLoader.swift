//
//  ImageLoader.swift
//  GithubSearch
//
//  Created by Iron Man on 08/11/25.
//

import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    
    private init() {}
    
    private let urlSession = URLSession.shared
    
    func loadImage(from stringUrl: String, completionHandler: @escaping(Result<UIImage, ApiError>) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: stringUrl)  else {return nil}
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error { return completionHandler(.failure(.networkError(error)))}
            
            guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                return completionHandler(.failure(.serverError(status: statusCode)))
            }
            
            guard let data, let image = UIImage(data: data) else {return completionHandler(.failure(.invalidDataReceived))}
            
            completionHandler(.success(image))
        }
        dataTask.resume()
        
        return dataTask
    }
}
