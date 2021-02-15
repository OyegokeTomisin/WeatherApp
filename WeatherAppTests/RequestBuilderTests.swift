//
//  RequestBuilderTests.swift
//  WeatherAppTests
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import XCTest
@testable import WeatherApp

class RequestBuilderTests: XCTestCase {

    func test_requestBuilder_Init() {
        let endpoint = EndpointSpy() as EndPoint
        let sut = RequestBuilder(route: endpoint)
        XCTAssertEqual(sut.request.url, URL(string: "https://a-given-url.com/random"))
        XCTAssertEqual(sut.request.httpMethod, "GET")
        XCTAssertNil(sut.request.httpBody)
        XCTAssertNil(sut.request.allHTTPHeaderFields)
    }

    private class EndpointSpy: EndPoint {
        var path: String { "/random"}

        var task: HTTPTask { .request }

        var httpMethod: HTTPMethod { .get }

        var baseURL: URL {
            return URL(string: "https://a-given-url.com")!
        }
    }
}
