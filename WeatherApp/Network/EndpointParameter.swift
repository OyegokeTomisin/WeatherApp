//
//  EndpointParameter.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 15/02/2021.
//

import Foundation

typealias Parameter = [String: Any]

protocol EndpointParameter {
    var asParameter: Parameter { get }
}
