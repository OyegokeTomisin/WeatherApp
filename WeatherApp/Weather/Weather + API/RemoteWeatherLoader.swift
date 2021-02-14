//
//  RemoteWeatherLoader.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

class RemoteWeatherLoader {

    let endpoint: EndPoint
    let client: NetworkClient

    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    init(endpoint: EndPoint, client: NetworkClient) {
        self.endpoint = endpoint
        self.client = client
    }

    func load(completion: @escaping (WeatherResult) -> Void) {
        client.request(endpoint) { result in
            switch result {
            case .success(let data, let response):
                completion(WeatherDataMapper.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
