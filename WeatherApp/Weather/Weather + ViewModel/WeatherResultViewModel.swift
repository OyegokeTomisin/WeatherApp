//
//  WeatherResultViewModel.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

class WeatherResultViewModel {

    let weather: Weather = .sunny(scene: .sea)

    var forecastCount: Int {
        return 5
    }

    func requestWeatherData(with userLocation: UserLocation) {
        let service = WeatherService(client: NetworkRouter(), location: userLocation)
        service.fetchWeatherData { currentWeatherResponse, weatherForecastResponse in

        }
    }

    func currentWeather_toViewModel() -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel(weather: weather)
    }

    func weatherForecast_toViewModel() -> WeatherForecastViewModel {
        return WeatherForecastViewModel(weather: weather)
    }
}
