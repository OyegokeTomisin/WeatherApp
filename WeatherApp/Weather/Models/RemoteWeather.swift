//
//  RemoteWeather.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 15/02/2021.
//

import Foundation

enum RemoteWeather: String {
    case thunderstorm
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case clouds

    var localized: Weather {
        switch  self {
        case .clear:
            return .sunny(scene: Weather.appScene)
        case .clouds:
            return .cloudy(scene: Weather.appScene)
        case .rain:
            return .rainy(scene: Weather.appScene)
        default:
            return .sunny(scene: Weather.appScene)
        }
    }
}
