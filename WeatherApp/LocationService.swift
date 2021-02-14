//
//  LocationService.swift
//  WeatherApp
//
//  Created by OYEGOKE TOMISIN on 14/02/2021.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    var notifyError: ((String) -> Void)?
    var notifyUserLocation: ((UserLocation) -> Void)?

    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        } else {
            notifyError?("Location services is not enabled")
        }
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkUpdatedLocation()
    }

    private func checkUpdatedLocation() {
        if let userLocation = locationManager.location?.coordinate {
            notifyUserLocation?(UserLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            checkUpdatedLocation()
        default:
            notifyError?("Location permission is not enabled")
        }
    }
}
