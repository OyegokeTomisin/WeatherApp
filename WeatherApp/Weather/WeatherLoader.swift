//
//  WeatherLoader.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

typealias WeatherResult = Result<RemoteWeatherData, Error>

protocol WeatherLoader {
    func load(completion: @escaping (WeatherResult) -> Void)
}
