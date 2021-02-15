//
//  WeatherResultViewModel.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

class WeatherResultViewModel {

    let weather: Weather = .sunny(scene: .sea)

    /*
     The Weather API includes weather forecast data with 3-hour step
     This implies it gives 8 (i.e 24/3) forcasts for a single day
     Therefore the total forecast over 5 days will be 5 * 8
    */
    private var limit: Int {
        return 5 * (24/3)
    }

    var notifyError: ((String) -> Void)?
    var notifyRefresh: (() -> Void)?

    var forecastCount: Int {
        return min(getFiveDayForcast().count, 5)
    }

    func currentWeather_toViewModel() -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel(weather: weather, weatherData: currentWeatherData?.weather?.first, tempData: currentWeatherData?.main)
    }

    func weatherForecast_toViewModel(for index: Int) -> WeatherForecastViewModel {
        let forecastData = getFiveDayForcast()[index]
        return WeatherForecastViewModel(weather: weather, tempratureData: forecastData.main, date: forecastData.forecastDate)
    }

    private func getFiveDayForcast() -> [ForeCastData] {
        guard let allData = weatherForcastData?.list else { return [] }
        let groupedData = Dictionary(grouping: allData) { formatDate($0.forecastDate) }
        let sortedData = groupedData.values.sorted { $0.first?.forecastDate ?? "0" < $1.first?.forecastDate ?? "0" }
        return sortedData.map { $0.first } .compactMap { $0 }
    }

    private func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: date) else { return "" }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: date)
    }

    private var currentWeatherData: RemoteWeatherData?
    private var weatherForcastData: RemoteWeatherData?

    func requestWeatherData(with userLocation: UserLocation) {

        let cQuery = WeatherLocationRequest(location: userLocation)
        let fQuery = WeatherLocationRequest(location: userLocation, limit: limit)

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
