//
//  Endpoint.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

typealias NetworkClientResult = Result<HTTPURLResponse, Error>
typealias NetworkRequestCompletion = (NetworkClientResult) -> Void

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var task: HTTPTask { get }
    var httpMethod: HTTPMethod { get }
}
