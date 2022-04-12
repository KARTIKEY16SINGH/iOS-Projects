//
//  HTTPUtility.swift
//  LocusAssignment
//
//  Created by Iron Man on 12/04/22.
//

import Foundation

struct HTTPUtility {
    func getApi<T: Decodable>(url: URL, type: T.Type, completionHandler: (T?) -> Void) {}
}
