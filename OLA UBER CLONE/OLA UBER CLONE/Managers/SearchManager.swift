//
//  SearchManager.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 05/02/22.
//

import Foundation
import MapKit

final class SearchManager {
    static let shared = SearchManager()
    private var locationSearch: MKLocalSearch?
    
    private func ini() {}
    
    func searchLocation(_ text: String, completionHandler: @escaping MKLocalSearch.CompletionHandler) {
        if let search = locationSearch {
            search.cancel()
        }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        locationSearch = MKLocalSearch(request: request)
        locationSearch?.start(completionHandler: completionHandler)
    }
}
