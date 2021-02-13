//
//  NetworkClient.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

protocol NetworkClient {
    func request(_ route: EndPoint, completion: @escaping NetworkRequestCompletion)
}
