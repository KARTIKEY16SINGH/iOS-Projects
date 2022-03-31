//
//  HTTPUtility.swift
//  Dunzo
//
//  Created by Iron Man on 16/03/22.
//

import Foundation

struct HTTPUtility {
    static func getDataFromApi<T: Decodable>(url: URL, returnType: T.Type, compeletionHandler: ((T?) -> Void)? ) {
        guard compeletionHandler != nil else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil && data != nil {
                do {
                    let result = try JSONDecoder().decode(returnType, from: data!)
//                    if let jsonString = String(data: data!, encoding: .utf8) {
//                        if let jsonDic = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as? [AnyHashable: Any] {
//                            debugPrint("jsonDic = ",jsonDic)
//                            for (key, value) in jsonDic {
//                                debugPrint("key \(key) = \(value)")
//                            }
//                        }
//                    }
                    compeletionHandler?(result)
                } catch {
                    debugPrint("Failed Data parsing")
                    compeletionHandler?(nil)
                }
                
            } else {
                debugPrint("Error response from api server")
                compeletionHandler?(nil)
            }
        }.resume()
    }
}
