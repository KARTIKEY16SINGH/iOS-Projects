//
//  HTTPUtility.swift
//  LocusAssignment
//
//  Created by Iron Man on 12/04/22.
//

import Foundation

struct HTTPUtility {
    func getApi<T: Decodable>(url: URL, type: T.Type, completionHandler: ((T?) -> Void)?) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                dump(error)
                completionHandler?(nil)
                return
            }
            dump(String(data: data, encoding: .utf8))
            do {
                let decodedResponse = try JSONDecoder().decode(type, from: data)
                completionHandler?(decodedResponse)
            } catch let parseError {
                dump(parseError)
                completionHandler?(nil)
            }
        }.resume()
    }
}
