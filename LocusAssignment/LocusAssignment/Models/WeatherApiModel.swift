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
    let forecasts: [Forecast]?
    let cod: String?
    let message: String?
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case forecasts = "list"
        case cod
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = (try? container.decode(Int.self, forKey: .count)) ?? 0
        forecasts = try? container.decode([Forecast].self, forKey: .forecasts)
        cod = try? container.decode(String.self, forKey: .cod)
        message = try? container.decode(String.self, forKey: .message)
    }
}
