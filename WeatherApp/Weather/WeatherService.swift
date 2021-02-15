//
//  WeatherService.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 15/02/2021.
//

import Foundation

final class WeatherService {

    let client: NetworkClient

    init(client: NetworkClient) {
        self.client = client
    }

    func fetchWeatherData(currentWeatherQuery: WeatherLocationRequest, forecastQuery: WeatherLocationRequest,
                          completion: @escaping (WeatherResult?, WeatherResult?) -> Void) {

        var currentGroup: WeatherResult?
        var forecastGroup: WeatherResult?

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        let currentGroupLoader = RemoteWeatherLoader(endpoint: WeatherEndpoint.current(query: currentWeatherQuery), client: client)
        currentGroupLoader.load { result in
            dispatchGroup.leave()
            currentGroup = result
        }

        dispatchGroup.enter()
        let forecastGroupLoader = RemoteWeatherLoader(endpoint: WeatherEndpoint.forecast(query: forecastQuery), client: client)
        forecastGroupLoader.load { result in
            dispatchGroup.leave()
            forecastGroup = result
        }

        dispatchGroup.notify(queue: .main) {
            completion(currentGroup, forecastGroup)
        }
    }
}
