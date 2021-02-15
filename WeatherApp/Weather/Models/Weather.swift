//
//  Weather.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

enum Weather {
    case rainy(scene: Scene)
    case sunny(scene: Scene)
    case cloudy(scene: Scene)

    static var appScene: Scene = .forest

    var identifier: String {
        switch self {
        case .rainy:
            return "rainy"
        case .sunny:
            return "sunny"
        case .cloudy:
            return "cloudy"
        }
    }
}
