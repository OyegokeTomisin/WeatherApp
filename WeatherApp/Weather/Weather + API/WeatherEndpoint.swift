//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

enum WeatherEndpoint {
    case current
    case forecast
}

extension WeatherEndpoint: EndPoint {

    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/")
        else { fatalError("Failed to configure weather endpoint base URL") }
        return url
    }

    var path: String {
        switch self {
        case .current:
            return "weather"
        case .forecast:
            return "forecast"
        }
    }

    var task: HTTPTask {
        return .request
    }

    var httpMethod: HTTPMethod {
       return .get
    }
}
