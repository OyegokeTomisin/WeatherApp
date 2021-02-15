//
//  NetworkRouterTests.swift
//  WeatherAppTests
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import XCTest
@testable import WeatherApp

class NetworkRouterTests: XCTestCase {

    override func setUp() {
        super.setUp()
        URLProtocolStub.startInterceptingRequests()
    }

    override func tearDown() {
        URLProtocolStub.stopInterceptingRequests()
        super.tearDown()
    }

    func test_request_performsRequestWithEndpoint() {
        let givenURL = URL(string: "https://a-given-url.com/random")!

        let exp = expectation(description: "Wait for completion")

        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, givenURL)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }

        makeSUT().request(AnyEndpoint().spy) { _ in }

        wait(for: [exp], timeout: 1.0)
    }

    func test_requestFromEndpoint_failsOnError() {
        let requestError = anyError
        let receivedError = resultErrorFor(data: nil, response: nil, error: requestError) as NSError?

        XCTAssertEqual(receivedError?.domain, requestError.domain)
        XCTAssertEqual(receivedError?.code, requestError.code)
    }

    func test_requestFromEndpoint_failsOnAllInvalidCases() {
        XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse, error: nil))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nil, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nonHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: anyHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nonHTTPURLResponse, error: nil))
    }

    func test_requestFromEndpoint_succeeedsOnResponseWithData() {
        let data = anyData
        let response = anyHTTPURLResponse

        let recievedValues = resultValuesFor(data: data, response: response, error: nil)

        XCTAssertEqual(recievedValues?.data, data)
        XCTAssertEqual(recievedValues?.response.url, response.url)
        XCTAssertEqual(recievedValues?.response.statusCode, response.statusCode)
    }

    func test_requestFromEndpoint_succeeedsOnResponseWithNilData() {
        let response = anyHTTPURLResponse
        let recievedValues = resultValuesFor(data: nil, response: response, error: nil)

        let emptyData = Data()
        XCTAssertEqual(recievedValues?.data, emptyData)
        XCTAssertEqual(recievedValues?.response.url, response.url)
        XCTAssertEqual(recievedValues?.response.statusCode, response.statusCode)
    }

    // MARK:- Helpers

    func makeSUT() -> NetworkClient {
        return NetworkRouter()
    }

    func resultErrorFor(data: Data?, response: URLResponse?, error: Error?,
                        file: StaticString = #file, line: UInt = #line) -> Error? {
        let result = resultFor(data: data, response: response, error: error, file: file, line: line)

        switch result {
        case let .failure(error):
            return error
        default:
            XCTFail("Expected failure, got \(result) instead", file: file, line: line)
            return nil
        }
    }

    func resultValuesFor(data: Data?, response: URLResponse?, error: Error?,
                         file: StaticString = #file, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
        let result = resultFor(data: data, response: response, error: error, file: file, line: line)
        switch result {
        case let .success(receivedData, receivedResponse ):
            return (receivedData, receivedResponse)
        default:
            XCTFail("Expected success, got \(result) instead", file: file, line: line)
            return nil
        }
    }

    func resultFor(data: Data?, response: URLResponse?, error: Error?,
                   file: StaticString = #file, line: UInt = #line) -> NetworkClientResult {
        URLProtocolStub.stub(data: data, response: response, error: error)

        let exp = expectation(description: "Wait for completion")

        var receivedResult: NetworkClientResult!

        makeSUT().request(AnyEndpoint().spy) { result in
            receivedResult = result
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)

        return receivedResult
    }

    private class URLProtocolStub: URLProtocol {

        private static var stub: Stub?
        private static var requestObserver: ((URLRequest) -> Void)?

        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }

        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error)
        }

        static func observeRequests(observer: @escaping (URLRequest) -> Void) {
            requestObserver = observer
        }

        static func startInterceptingRequests() {
            registerClass(self)
        }

        static func stopInterceptingRequests() {
            unregisterClass(self)
            stub = nil
            requestObserver = nil
        }

        override class func canInit(with request: URLRequest) -> Bool {
            requestObserver?(request)
            return true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }

            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }

            client?.urlProtocolDidFinishLoading(self)
        }

        override func stopLoading() { }
    }

    private var anyError: NSError { NSError(domain: "Test", code: 0) }

    private var anyURL: URL { URL(string: "https://a-given-url.com/random")! }

    private var anyData: Data {
        return Data("any data".utf8)
    }

    private var nonHTTPURLResponse: URLResponse {
        URLResponse(url: anyURL, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }
    
    private var anyHTTPURLResponse: HTTPURLResponse {
        HTTPURLResponse(url: anyURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
    }

    class AnyEndpoint {

        var spy: EndPoint { EndpointSpy() }

        var request: URLRequest { RequestBuilder(route: spy).request }

        private class EndpointSpy: EndPoint {
            var path: String { "/random"}

            var task: HTTPTask { .request }

            var httpMethod: HTTPMethod { .get }

            var baseURL: URL {
                return URL(string: "https://a-given-url.com")!
            }
        }
    }
}
