//
//  RemoteWeatherResponse.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

struct RemoteWeatherData: Decodable {
    let name: String?
    let weather: [WeatherData]?
    let main: TemperatureData?
    let list: [ForeCastData]?
}

struct TemperatureData: Decodable {
    let temp: Double
    let tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WeatherData: Decodable {
    let weatherID: Int
    let main, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherID = "id"
        case weatherDescription = "description"
    }
}

struct ForeCastData: Decodable {
    let weather: [WeatherData]
    let main: TemperatureData
    let forecastDate: String

    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case forecastDate = "dt_txt"
    }
}
