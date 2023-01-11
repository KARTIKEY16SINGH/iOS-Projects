//
//  LocationManager.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 20/04/22.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    static let shared: LocationManager = LocationManager()
    private override init () {
        super.init()
        _locationManager.delegate = self
    }
    private let _locationManager: CLLocationManager = CLLocationManager()
    @objc dynamic var currentLocation: CLLocation?
    
    func requestLocationAuthorization() {
        switch _locationManager.authorizationStatus {
        case .notDetermined:
            _locationManager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            _locationManager.requestLocation()
        default:
            showPopupEnableLocationPermission()
        }
    }
    
    private func showPopupEnableLocationPermission() {
        MALog(printText: "")
    }
    
    func requestOneTimeLocation() {
        _locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        MALog(printText: "locations: \(locations)")
        currentLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        MALog(printText: "error = \(error)")
    }
}
