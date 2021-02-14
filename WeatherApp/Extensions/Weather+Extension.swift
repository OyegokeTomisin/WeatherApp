//
//  Weather+Extension.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 13/02/2021.
//

import UIKit

extension Weather {

    var colour: UIColor {
        switch self {
        case .rainy:
            return UIColor.rainy
        case .cloudy:
            return UIColor.cloudy
        case .sunny(let scene):
            switch scene {
            case .sea:
                return UIColor.sunnySea
            case .forest:
                return UIColor.sunnyForest
            }
        }
    }

    var image: UIImage {
        switch self {
        case .rainy:
            return UIImage(named: identifier)!
        case .sunny:
            return UIImage(named: identifier)!
        case .cloudy:
            return UIImage(named: identifier)!
        }
    }

    var headerImage: UIImage {
        switch self {
        case .rainy(let scene):
            switch scene {
            case .sea:
                return UIImage(named: "sea_rainy")!
            case .forest:
                return UIImage(named: "forest_rainy")!
            }
        case .sunny(let scene):
            switch scene {
            case .sea:
                return UIImage(named: "sea_sunny")!
            case .forest:
                return UIImage(named: "forest_sunny")!
            }
        case .cloudy(let scene):
            switch scene {
            case .sea:
                return UIImage(named: "sea_cloudy")!
            case .forest:
                return UIImage(named: "forest_cloudy")!
            }
        }
    }
}
