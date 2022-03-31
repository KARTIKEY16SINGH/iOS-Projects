//
//  LLD+Main+Search+Screen.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 30/03/22.
//

import UIKit
import MapKit

class MainScreenVC {
    weak var tableView: UITableView!
    weak var searchDestBtn: UIButton!
    weak var mapView: MKMapView!
    
    @IBAction func searchBtnClicked() {}
    func updatePickupOnMapView(_ pickUp: MKMapItem) {}
}

//extension MainScreenVC: UITableViewDataSource {}
//extension MainScreenVC: UITableViewDataSource {}

protocol NavigateToBooking: AnyObject {  // I did not get a good name for this protocol
    func navigateToBooking()
}

protocol MainScreen: NavigateToBooking {
    func navigateToSeachScreen()
    func receivedSourceLocation(_ pickUp: MKMapItem)
    func navigateToBooking()
}

struct MainScreenViewModel {
    private var _prevDestinations: [MKMapItem]?
    func getPickUpLocation() {}
    func getPreviousDestinations(){}
    func setDestination(atIndex index: Int) {}
}

class SearchScreenVC {
    weak var pickUpSearchBar: UISearchBar!
    weak var destSearchBar: UISearchBar!
    weak var tableView: UITableView!
}

protocol SearchScreen: NavigateToBooking  {
    func setLocations(text: String)
    func receivedSearchResult()
    func navigateToBooking()
}

struct SearchScreenViewModel {
//    private var _isPickUpSelected: Bool = false
    private var _searchResult: [MKMapItem]?
    func getPickUpLocation() {}
    func searchLocation(text: String) {}
    func setLocation(atIndex index: Int, forDestination: Bool) {}
}

final class RideManager {
    static let shared = RideManager()
    private var currentRide: Ride!
    
    private init() {}
    
    func setSource(src: MKMapItem) {}
    func setDestination(dst: MKMapItem) {}
    func isReadyForBooking() -> Bool {
        currentRide.source != nil && currentRide.destination != nil
    }
}

struct Ride {
    var source: MKMapItem?
    var destination: MKMapItem?
}

protocol Search {
    associatedtype SearchItemType
    associatedtype SearchResponseType
    func search(_ searchItem: SearchItemType, completionHandler: ((SearchResponseType?) -> Void)?)
}

class LocationSearchApiRepository: Search {
    func search(_ searchItem: String?, completionHandler: (([MKMapItem]?) -> Void)?) {
        // Location Search Code Using MKLocalSearch
        // Also it will Debounce Technique
    }
    
    typealias SearchItemType = String?
    
    typealias SearchResponseType = [MKMapItem]
    
    private var _workItem: DispatchWorkItem?
    
}
