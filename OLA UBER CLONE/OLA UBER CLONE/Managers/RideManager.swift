//
//  RideManager.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 12/02/22.
//
import MapKit
import Foundation

struct Ride {
    var source: MKMapItem?
    var destination: MKMapItem?
}

final class RideManager {
    static let shared = RideManager()
    private var _currentRide: Ride!
    
    private init() {
        // It will set currentRides pickUP location using MKMapItems's class func
        // class func forCurrentLocation() -> MKMapItem
        _currentRide = Ride(source: MKMapItem.forCurrentLocation(), destination: nil)
    }
    
    func setSource(src: MKMapItem?) {}
    func setDestination(dst: MKMapItem?) {}
    func isReadyForBooking() -> Bool {
        _currentRide.source != nil && _currentRide.destination != nil
    }
    func getSource() -> MKMapItem? {return _currentRide.source}
    func getDestination() -> MKMapItem? {return _currentRide.destination}
}
