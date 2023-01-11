//
//  MainScreenViewModel.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 09/04/22.
//

import Foundation
import MapKit.MKMapItem

protocol BasicSearchScreen: AnyObject {
    func navigateToBooking()
    func receivedSourceLocation(_ pickUp: MKMapItem)
}

protocol MainScreen: BasicSearchScreen {
    func navigateToSeachScreen()
    func receivedPreviousDestination()
    func failedToReceivePreviousDestination()
    func receivedZeroPreviousDestination()
}

final class MainScreenViewModel: NSObject {
    private weak var _view : MainScreen?
    private var _prevDestinations: [Location]?
    private let _rideManager = RideManager.shared
    private let _prevDestApiRepo = PreviousDestinationApiRepository()
    private var observation: NSKeyValueObservation?
    @objc private let _locationManager = LocationManager.shared
    init(_ view: MainScreen) {
        self._view = view
        super.init()
        observation = observe(\._locationManager.currentLocation, options: [.old, .new]) {
            object, change in
            MALog("myDate changed from: \(change.oldValue!), updated to: \(change.newValue!)")
            let placeMark = MKPlacemark(coordinate: change.newValue!!.coordinate)
            let mapItem = MKMapItem(placemark: placeMark)
            view.receivedSourceLocation(mapItem)
        }
    }
    func getPickUpLocation() {
        guard let pickUp = _rideManager.getSource() else {
            
            return
        }
        _view?.receivedSourceLocation(pickUp)
    } // call on viewWillAppear
    
    func searchBtnTapped() {} // navigate to search screen
    func getPreviousDestinations(){
        _prevDestApiRepo.fetchAllData {[weak self] locationArray in
            guard let wSelf = self else {return}
            if let locationArray = locationArray {
                wSelf._prevDestinations = locationArray
                if locationArray.count == 0 {
                    DispatchQueue.main.async {
                        wSelf._view?.receivedZeroPreviousDestination()
                    }
                } else {
                    DispatchQueue.main.async {
                        wSelf._view?.receivedPreviousDestination()
                    }
                }
            } else {
                DispatchQueue.main.async(execute: {wSelf._view?.failedToReceivePreviousDestination()})
            }
        }
    }
    
    // Table View Related functions
    func setDestination(atIndex index: Int) {} // Will Set Destination using RideManager and navigate to booking screen if isReadyForBooking
    func getNumberOfDestination() -> Int {return _prevDestinations?.count ?? 0}
    func getDestination(forRow index: Int) -> LocationItem {
        guard let data = _prevDestinations?[index] else {
            return LocationItem(title: "", address: "")
        }
        return LocationItem(title: data.name, address: data.postalAddress)
    }
}
