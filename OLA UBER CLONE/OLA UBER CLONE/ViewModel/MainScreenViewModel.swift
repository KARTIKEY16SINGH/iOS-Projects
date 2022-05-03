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
}

class MainScreenViewModel {
    private weak var _view : MainScreen?
    private var _prevDestinations: [Location]?
    private let _rideManager = RideManager.shared
    private let _prevDestApiRepo = PreviousDestinationApiRepository()
    init(_ view: MainScreen) {
        self._view = view
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
            } else {
                wSelf._view?.failedToReceivePreviousDestination()
            }
        }
    } // only called on view did load
    
    // Table View Related functions
    func setDestination(atIndex index: Int) {} // Will Set Destination using RideManager and navigate to booking screen if isReadyForBooking
    func getNumberOfDestination() -> Int {return _prevDestinations?.count ?? 0}
    func getDestination(forRow index: Int) {} // MARK: This function will return data like Name, Address for destination and provided index
}
