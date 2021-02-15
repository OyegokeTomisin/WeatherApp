//
//  WeatherLocationRequest.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 15/02/2021.
//

import Foundation

struct WeatherLocationRequest {

    let location: UserLocation
    var limit: Int?

    var apiKey: String {
        SessionManager.environment.openWeatherAPIKey
    }

    var unit: String {
        return "metric"
    }
}

extension WeatherLocationRequest: EndpointParameter {
    var asParameter: Parameter {
        var params: Parameter =
            ["lat": location.latitude, "lon": location.longitude, "appid": apiKey, "units": unit]
        if let limit = limit {
            params["cnt"] = limit
        }
        return params
    }
}
