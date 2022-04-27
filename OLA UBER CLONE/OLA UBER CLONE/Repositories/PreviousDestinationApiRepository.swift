//
//  PreviousDestinationApiRepository.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 27/04/22.
//

import Foundation

protocol BasicRepository {
    associatedtype T
    func fetchAllData(completionHandler: @escaping (T?)->Void)
}

struct PreviousDestinationApiRepository: BasicRepository {
    private let _api = "https://something"
    func fetchAllData(completionHandler: @escaping (LocationArray?) -> Void) {
        if let url = URL(string: _api) {
            HTTPUtility.getApi(url, type: LocationArray.self, completionHandler: completionHandler)
        } else {
            completionHandler(nil)
        }
    }
    
    typealias T = LocationArray
}
