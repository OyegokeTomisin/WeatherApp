//
//  RemoteWeatherLoaderTests.swift
//  WeatherAppTests
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import XCTest
@testable import WeatherApp

class RemoteWeatherLoaderTests: XCTestCase {

    func test_init_DoesNotRequestDataFromEndpoint() {
        let (_, client) = makeSUT()
        XCTAssert(client.requestedURLs.isEmpty)
    }

    func test_request_loadsDataFromEndpoint() {
        let (sut, client) = makeSUT()

        sut.load { _ in }

        XCTAssertEqual([sut.endpoint.baseURL], client.requestedURLs)
    }

    func test_request_loadsDataFromEndpointMultiple() {
        let (sut, client) = makeSUT()

        let url = sut.endpoint.baseURL

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnFailure() {
        let (sut, client) = makeSUT()

        var capturedErrors = [RemoteWeatherLoader.Error]()
        sut.load { result in
            switch result {
            case .success:
                XCTFail("Request failed to deliver error")
            case .failure(let error):
                capturedErrors.append(error as! RemoteWeatherLoader.Error)
            }
        }

        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)

        XCTAssertEqual(capturedErrors, [.connectivity])
    }

    func test_load_deliversErrorOnNon200HttpResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]
        samples.enumerated().forEach { (index, code) in

            let exp = expectation(description: "Wait for load completion")

            var capturedErrors = [RemoteWeatherLoader.Error]()

            sut.load { result in
                switch result {
                case .success:
                    XCTFail("Request failed to deliver error")
                case .failure(let error):
                    capturedErrors.append(error as! RemoteWeatherLoader.Error)
                }

                exp.fulfill()
            }

            client.complete(withStatusCode: code, data: makeCurrentWeatherJSON([]), at: index)

            XCTAssertEqual(capturedErrors, [.invalidData])

            wait(for: [exp], timeout: 1.0)
        }
    }

    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        var capturedErrors = [RemoteWeatherLoader.Error]()
        sut.load { result in
            switch result {
            case .success:
                XCTFail("Request failed to deliver error")
            case .failure(let error):
                capturedErrors.append(error as! RemoteWeatherLoader.Error)
            }
        }

        let invalidJSON = Data("invalid json".utf8)

        client.complete(withStatusCode: 200, data: invalidJSON)

        XCTAssertEqual(capturedErrors, [.invalidData])
    }

    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let data = anyCurrentWeatherData()

        let exp = expectation(description: "Wait for load completion")

        let expectedResult =
            WeatherDataMapper.RemoteWeatherData(name: "Shuzenji", weather: [WeatherDataMapper.WeatherData(weatherID: 803, main: "Clouds", weatherDescription: "broken clouds")], main: WeatherDataMapper.TemperatureData(temp: 281.48, tempMin: 281.48, tempMax: 281.48))

        sut.load { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.name, expectedResult.name)
            case .failure:
                XCTFail("Request failed to deliver decoded response")
            }
            exp.fulfill()
        }

        client.complete(withStatusCode: 200, data: data)

        wait(for: [exp], timeout: 1.0)
    }

    // MARK: - Helpers
    private class EndpointSpy: EndPoint {
        var path: String { "/"}

        var task: HTTPTask { .request }

        var httpMethod: HTTPMethod { .get }

        var baseURL: URL {
            return URL(string: "https://a-given-url.com")!
        }
    }

    private class NetworkClientSpy: NetworkClient {

        var requestedURLs: [URL] {
            messages.map { $0.url }
        }

        var capturedErrors = [Error]()

        var messages = [(url: URL, completions: NetworkRequestCompletion)]()

        func request(_ route: EndPoint, completion: @escaping NetworkRequestCompletion) {
            messages.append((route.baseURL, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completions(.failure(error))
        }

        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index],statusCode: code,
                httpVersion: nil, headerFields: nil)!
            messages[index].completions(.success(data, response))
        }
    }

    private func makeSUT() -> (RemoteWeatherLoader, NetworkClientSpy) {
        let endpoint = EndpointSpy()
        let client = NetworkClientSpy()
        let sut = RemoteWeatherLoader(endpoint: endpoint, client: client)
        return (sut, client)
    }

    private func anyURL() -> URL {
        return URL(string: "https://a-given-url.com")!
    }

    private func makeCurrentWeatherJSON(_ items: [[String: Any]]) -> Data {
        let json = ["weather": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }

    func anyCurrentWeatherData() -> Data {
        let path = Bundle(for: type(of: self)).path(forResource: "MockCurrentWeatherData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        return data
    }
}
