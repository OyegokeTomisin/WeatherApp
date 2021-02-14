//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

struct CurrentWeatherViewModel {

    let weather: Weather

    var maxTemp: String {
        return String(17)
    }

    var minTemp: String {
        return String(10)
    }

    var currentTemp: String {
        return String(15)
    }

    var tempDescription: String {
        return "Sunny".uppercased()
    }
}
