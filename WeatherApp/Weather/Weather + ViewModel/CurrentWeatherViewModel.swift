//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

struct CurrentWeatherViewModel {

    let weather: Weather
    let weatherData: WeatherData?
    let tempData: TemperatureData?

    var maxTemp: String {
        return String(tempData?.tempMax ?? 0) + "°"
    }

    var minTemp: String {
        return String(tempData?.tempMin ?? 0) + "°"
    }

    var currentTemp: String {
        return String(tempData?.temp ?? 0) + "°"
    }

    var tempDescription: String? {
        return weatherData?.main.uppercased()
    }
}
