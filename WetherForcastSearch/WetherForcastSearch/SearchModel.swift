//
//  SearchModel.swift
//  WetherForcastSearch
//
//  Created by Iron Man on 14/11/25.
//

struct CityModal: Decodable {
    let result: [CityInfo]
}

struct CityInfo: Decodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let elevation: Double
    let countryCode: String
    let timezone: String
    let population: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude
        case longitude
        case elevation
        case timezone
        case population
        case countryCode = "country_code"
    }
}

struct ForecastModel: Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currentWeatherInfo: CurrentWeatherInfo
    let dailyWeatherInfo: DailyWeatherInfo
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case currentWeatherInfo = "current_weather"
        case dailyWeatherInfo = "daily"
    }
    
}

struct CurrentWeatherInfo: Decodable {
    let temperature: Float
    let windSpeed: Float
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case temperature
        case windSpeed = "wind_speed"
        case time
    }
}

struct DailyWeatherInfo: Decodable {
    let time: [String]
    let temperatureMax: [Float]
    let temperatureMin: [Float]
    let weatherCode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
        case weatherCode = "weathercode"
    }
}

struct SearchDailyDataSourceItem {
    let time: String
    let maxTemperature: Float
    let minTemperature: Float
    let weatherCode: Int
}
