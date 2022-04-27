//
//  LocationManager.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 20/04/22.
//

import Foundation
import CoreLocation

final class LocationManager {
    static let shared: LocationManager = LocationManager()
    private init () {}
    private let _locationManager: CLLocationManager = CLLocationManager()
    
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
        
    }
}
