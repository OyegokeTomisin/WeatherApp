//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

enum WeatherEndpoint {
    case current(query: EndpointParameter)
    case forecast(query: EndpointParameter)
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
        switch self {
        case let .current(query), let .forecast(query):
            return .requestWithParameters(urlParameters: query.asParameter)
        }
    }

    var httpMethod: HTTPMethod {
       return .get
    }
}
