//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation

struct WeatherForecastViewModel {

    let weather: Weather

    let tempratureData: TemperatureData?
    let date: String?

    var day: String {
        guard let date = date else { return "N/A" }
        return formatDate(date)
    }

    var temprature: String {
        return String(tempratureData?.temp ?? 0) + " °"
    }

    private func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: date) else { return "" }
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: date)
    }
}
