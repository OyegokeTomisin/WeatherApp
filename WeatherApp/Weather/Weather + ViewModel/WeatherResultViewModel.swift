//
//  WeatherResultViewModel.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

class WeatherResultViewModel {

    let weather: Weather = .sunny(scene: .sea)

    func currentWeather_toViewModel() -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel(weather: weather)
    }

    func weatherForecast_toViewModel() -> WeatherForecastViewModel {
        return WeatherForecastViewModel(weather: weather)
    }
}
