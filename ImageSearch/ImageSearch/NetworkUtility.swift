//
//  NetworkUtility.swift
//  ImageSearch
//
//  Created by Iron Man on 18/05/21.
//

import Foundation

struct NetworkUtility {
    static func getData<T : Decodable>(fromUrl url : URL, decodeType type : T.Type, completionHandler : @escaping (T) -> ()) {
        print("[Network] getting data for URL = \(url)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("[Network] response received")
            if error == nil && data != nil {
                do {
                    let res = try JSONDecoder().decode(T.self, from: data!)
                    print("[Network] Response received = \(res)")
                    completionHandler(res)
                } catch let error {
                    print("[Network] Error = \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    static func getImageData(fromURL url : URL, completionHandler : @escaping (Data) -> ()) {
        print("[Network] getting image for URL = \(url)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("[Network] image response received")
            if error == nil && data != nil {
                completionHandler(data!)
            }
        }.resume()
    }
}
