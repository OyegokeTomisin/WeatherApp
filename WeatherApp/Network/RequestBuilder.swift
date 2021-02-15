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
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        setParameters(for: &request)
        return request
    }

    private func setParameters(for  request: inout URLRequest) {
        switch endpoint.task {
        case .request:
            break
        case let .requestWithParameters(urlParameters):
            if let url = request.url, let parameters = urlParameters, !parameters.isEmpty {
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    urlComponents.queryItems = [URLQueryItem]()
                    for (key, value) in parameters {
                        let queryItem = URLQueryItem(name: key, value: "\(value)")
                        urlComponents.queryItems?.append(queryItem)
                    }
                    request.url = urlComponents.url
                }
            }
        }
    }
}
