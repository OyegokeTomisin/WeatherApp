//
//  WeatherResultViewModel.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

class WeatherResultViewModel {

    let weather: Weather = .rainy(scene: .sea)

    func currentWeather_toViewModel() -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel(weather: weather)
    }
}
