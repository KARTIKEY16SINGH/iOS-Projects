//
//  HTTPUtility.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 27/04/22.
//

import Foundation

struct HTTPUtility {
    static func getApi<T: Decodable>(_ url: URL, type: T.Type, completionHandler: @escaping (T?)->Void) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if error == nil && data != nil {
                let decodedData = try? JSONDecoder().decode(type, from: data!)
                completionHandler(decodedData)
            } else {
                completionHandler(nil)
            }
        }
    }
}
