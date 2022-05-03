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
    private let _apiPath = "users/userID/previousDestinations"
    func fetchAllData(completionHandler: @escaping ([Location]?) -> Void) {
        FirebaseDBManager.shared.getOneTimeValue(atPath: _apiPath, type: T.self, completionHandler: completionHandler)
    }
    
    typealias T = [Location]
}
