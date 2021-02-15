//
//  NetworkRouter.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import Foundation

final class NetworkRouter: NetworkClient {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    func request(_ route: EndPoint, completion: @escaping NetworkRequestCompletion) {
        let request = RequestBuilder(route: route).request
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
