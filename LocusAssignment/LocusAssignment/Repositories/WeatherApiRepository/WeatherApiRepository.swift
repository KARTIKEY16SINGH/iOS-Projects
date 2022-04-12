//
//  WeatherApiRepository.swift
//  LocusAssignment
//
//  Created by Iron Man on 12/04/22.
//

import Foundation

struct WeatherApiRepository {
    private let _httpUtility = HTTPUtility()
    
    private let _apiHost = "api.openweathermap.org"//"pro.openweathermap.org"
    private let _apiScheme = "https"
    private let _apiPath = "/data/2.5/forecast"//"data/2.5/forecast/hourly"
    
    private func getURL(_ queryItems: [URLQueryItem]?) -> URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = _apiScheme
        urlComponent.host = _apiHost
        urlComponent.path = _apiPath
        urlComponent.queryItems = queryItems
        return urlComponent.url
    }
    
    func fetch(_ cityName: String, completionHandler: (WeatherApiModel?)->Void) {
        var urlQueries: [URLQueryItem] = [URLQueryItem(name: "q", value: cityName)]
        urlQueries.append(URLQueryItem(name: "appId", value: ""))
        guard let apiURL = getURL(urlQueries) else {
            return
        }
        _httpUtility.getApi(url: apiURL, type: WeatherApiModel.self) { weatherResponse in
            completionHandler(weatherResponse)
        }
    }
}
