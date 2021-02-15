//
//  WeatherService.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 15/02/2021.
//

import Foundation

final class WeatherService {

    let client: NetworkClient

    init (client: NetworkClient) {
        self.client = client
    }

    private func fetchWeatherData(completion: @escaping (WeatherResult?, WeatherResult?) -> Void) {

        var currentGroup: WeatherResult?
        var forecastGroup: WeatherResult?

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        fetchCurrenWeatherData(endpoint: .current) { result in
            dispatchGroup.leave()
            currentGroup = result
        }

        dispatchGroup.enter()
        fetchWeatherForcast(endpoint: .forecast) { result in
            dispatchGroup.leave()
            forecastGroup = result
        }

        dispatchGroup.notify(queue: .main) {
            completion(currentGroup, forecastGroup)
        }
    }

    func fetchCurrenWeatherData(endpoint: WeatherEndpoint, completion: @escaping (WeatherResult) -> Void) {
        let loader = RemoteWeatherLoader(endpoint: endpoint, client: client)
        loader.load(completion: completion)
    }

    func fetchWeatherForcast(endpoint: WeatherEndpoint, completion: @escaping (WeatherResult) -> Void) {
        let loader = RemoteWeatherLoader(endpoint: endpoint, client: client)
        loader.load(completion: completion)
    }
}
