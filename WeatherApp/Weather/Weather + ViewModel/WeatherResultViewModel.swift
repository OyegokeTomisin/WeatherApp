//
//  WeatherResultViewModel.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

class WeatherResultViewModel {

    let weather: Weather = .sunny(scene: .sea)

    private var numberOfDays: Int {
        return 5
    }

    var notifyError: ((String) -> Void)?
    var notifyRefresh: (() -> Void)?

    var forecastCount: Int {
        return weatherForcastData?.list?.count ?? 0
    }

    func currentWeather_toViewModel() -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel(weather: weather, weatherData: currentWeatherData?.weather?.first, tempData: currentWeatherData?.main)
    }

    func weatherForecast_toViewModel() -> WeatherForecastViewModel {
        return WeatherForecastViewModel(weather: weather)
    }

    private var currentWeatherData: RemoteWeatherData?
    private var weatherForcastData: RemoteWeatherData?

    func requestWeatherData(with userLocation: UserLocation) {

        let cQuery = WeatherLocationRequest(location: userLocation)
        let fQuery = WeatherLocationRequest(location: userLocation, limit: numberOfDays)

        let service = WeatherService(client: NetworkRouter())
        service.fetchWeatherData(currentWeatherQuery: cQuery, forecastQuery: fQuery) { [weak self] currentWeatherResponse, weatherForecastResponse in

            if let currentWeatherResponse = currentWeatherResponse,
               let weatherForecastResponse = weatherForecastResponse {

                switch currentWeatherResponse {
                case .success(let response):
                    self?.currentWeatherData = response
                case .failure(let error):
                    self?.notifyError?(error.localizedDescription)
                }

                switch weatherForecastResponse {
                case .success(let response):
                    self?.weatherForcastData = response
                case .failure(let error):
                    self?.notifyError?(error.localizedDescription)
                }
            }
            self?.notifyRefresh?()
        }
    }
}
