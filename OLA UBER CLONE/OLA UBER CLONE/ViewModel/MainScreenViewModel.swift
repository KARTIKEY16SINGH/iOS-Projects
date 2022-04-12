//
//  MainScreenViewModel.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 09/04/22.
//

import Foundation
import MapKit.MKMapItem

struct MainScreenViewModel {
    private var _prevDestinations: [MKMapItem]?
    func getPickUpLocation() {} // call on viewWillAppear
    func searchBtnTapped() {} // navigate to search screen
    func getPreviousDestinations(){} // only called on view did load
    
    // Table View Related functions
    func setDestination(atIndex index: Int) {} // Will Set Destination using RideManager and navigate to booking screen if isReadyForBooking
    func getNumberOfDestination() -> Int {return _prevDestinations?.count ?? 0}
    func getDestination(forRow index: Int) {} // MARK: This function will return data like Name, Address for destination and provided index
}
