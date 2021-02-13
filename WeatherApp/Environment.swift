//
//  Environment.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

enum Environment {
    case production
    case development

    var openWeatherAPIKey: String {
        switch self {
        case .production:
            return "f2160a8f1f25f327507c8d6e9ad9b7fa"
        case .development:
            return "f2160a8f1f25f327507c8d6e9ad9b7fa"
        }
    }
}
