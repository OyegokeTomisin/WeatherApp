//
//  Endpoint.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

public enum NetworkClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

typealias NetworkRequestCompletion = (NetworkClientResult) -> Void

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var task: HTTPTask { get }
    var httpMethod: HTTPMethod { get }
}
