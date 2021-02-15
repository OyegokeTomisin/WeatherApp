//
//  WeatherLocationRequest.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 15/02/2021.
//

import Foundation

struct WeatherLocationRequest {

    let location: UserLocation

    var apiKey: String {
        SessionManager.environment.openWeatherAPIKey
    }

    var unit: String {
        return "metric"
    }
}

extension WeatherLocationRequest: EndpointParameter {
    var asParameter: Parameter {
        return ["lat": location.latitude, "lon": location.longitude, "appid": apiKey, "units": unit]
    }
}
