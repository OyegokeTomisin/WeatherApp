//
//  WeatherService.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 15/02/2021.
//

import Foundation

final class WeatherService {

    let client: NetworkClient
    let location: UserLocation

    private var query: WeatherLocationRequest {
        return WeatherLocationRequest(location: location)
    }

    init(client: NetworkClient, location: UserLocation) {
        self.client = client
        self.location = location
    }

    func fetchWeatherData(completion: @escaping (WeatherResult?, WeatherResult?) -> Void) {

        var currentGroup: WeatherResult?
        var forecastGroup: WeatherResult?

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        fetchCurrenWeatherData(endpoint: .current(query: query)) { result in
            dispatchGroup.leave()
            currentGroup = result
        }

        dispatchGroup.enter()
        fetchWeatherForcast(endpoint: .forecast(query: query)) { result in
            dispatchGroup.leave()
            forecastGroup = result
        }

        dispatchGroup.notify(queue: .main) {
            completion(currentGroup, forecastGroup)
        }
    }

    private func fetchCurrenWeatherData(endpoint: WeatherEndpoint, completion: @escaping (WeatherResult) -> Void) {
        let loader = RemoteWeatherLoader(endpoint: endpoint, client: client)
        loader.load(completion: completion)
    }

    private func fetchWeatherForcast(endpoint: WeatherEndpoint, completion: @escaping (WeatherResult) -> Void) {
        let loader = RemoteWeatherLoader(endpoint: endpoint, client: client)
        loader.load(completion: completion)
    }
}
