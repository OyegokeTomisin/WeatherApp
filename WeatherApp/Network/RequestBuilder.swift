//
//  RequestBuilder.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

final class RequestBuilder {

    private let endpoint: EndPoint

    var request: URLRequest {
        return createRequest()
    }

    init(route: EndPoint) {
        self.endpoint = route
    }

    private func createRequest() -> URLRequest {
        return URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
    }
}
