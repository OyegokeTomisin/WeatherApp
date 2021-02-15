import Foundation

final class WeatherDataMapper {

    private static var statusOK: Int { return 200 }

    static func map(_ data: Data, from response: HTTPURLResponse) -> WeatherResult {
        guard response.statusCode == statusOK,
              let root = try? JSONDecoder().decode(RemoteWeatherData.self, from: data) else {
            return .failure(RemoteWeatherLoader.Error.invalidData)
        }
        return .success(root)
    }
}
