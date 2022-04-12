//
//  WeatherApiModel.swift
//  LocusAssignment
//
//  Created by Iron Man on 12/04/22.
//

import Foundation

struct Temperatures: Decodable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Forecast: Decodable {
    let time: Int
    let temperatures: Temperatures
    let weather: [Weather]
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case temperatures = "main"
        case weather
    }
}

struct WeatherApiModel: Decodable {
    let count: Int
    let forecasts: [Forecast]
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case forecasts = "list"
    }
}
