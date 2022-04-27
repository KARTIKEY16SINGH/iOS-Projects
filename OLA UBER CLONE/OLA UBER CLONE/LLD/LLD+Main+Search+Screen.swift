//
//  LLD+Main+Search+Screen.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 30/03/22.
//

import UIKit
import MapKit

class LLDMainSearchScreen {
    class MainScreenVC: UIViewController {
        weak var tableView: UITableView!
        weak var searchDestBtn: UIButton!
        weak var mapView: MKMapView!
        
        @IBAction func searchBtnClicked() {}
        func updatePickupOnMapView(_ pickUp: MKMapItem) {}
    }
    
    // MARK: MainScreenViewController will also implement following extenstions
    //extension MainScreenVC: UITableViewDataSource {}
    //extension MainScreenVC: UITableViewDelegate {}
    //extension MainScreenVC: MainScreen {}
    
//    protocol BasicSearchScreen: AnyObject {  // I did not get a good name for this protocol
//        associatedtype T
//        func navigateToBooking()
//        func receivedSourceLocation(_ pickUp: T)
//    }
    
//    protocol MainScreen: BasicSearchScreen {
//        associatedtype T = MKMapItem
//        func navigateToSeachScreen()
//        func receivedPreviousDestination()
//        func failedToReceivePreviousDestination()
//    }
    
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
    
    // MARK: By default on launch destination search bar will be highlighted and pickup search will show current selected pickup location if any else current location
    class SearchScreenVC: UIViewController {
        weak var pickUpSearchBar: UISearchBar!
        weak var destSearchBar: UISearchBar!
        weak var tableView: UITableView!
    }
    
    // MARK: SearchScreenVC will also implement following extensions
    //extension SearchScreenVC: UITableViewDataSource {}
    //extension SearchScreenVC: UITableViewDelegate {}
    //extension SearchScreenVC: SearchScreen {}
    
//    protocol SearchScreen: BasicSearchScreen  {
//        associatedtype T = String
//        func showSelectedLocation(text: String)
//        func receivedSearchResult()
//    }
    
//    struct SearchScreenViewModel {
//        //    private var _isPickUpSelected: Bool = false
//        private var _searchResult: [MKMapItem]?
//        private let _locationSearchApiRepo = LocationSearchApiRepository()
//        func getPickUpLocation() {} // called only once
//        func searchLocation(text: String) {} // Search Location using LocationSearchApiRepository
//        func setLocation(atIndex index: Int, forDestination: Bool) {} // set RideManager destination location. if can move to booking screen then tell view to navigate to booking else tell to set current selected location
//        func getNumberOfLocations() -> Int {0}
//        func getLocation(forIndex index:Int) {} // MARK: This function will return data like Name, Address for location at provided index
//    }
    
//    final class RideManager {
//        static let shared = RideManager()
//        private var _currentRide: Ride!
//        
//        private init() {
//            // It will set currentRides pickUP location using MKMapItems's class func
//            // class func forCurrentLocation() -> MKMapItem
//        }
//        
//        func setSource(src: MKMapItem?) {}
//        func setDestination(dst: MKMapItem?) {}
//        func isReadyForBooking() -> Bool {
//            _currentRide.source != nil && _currentRide.destination != nil
//        }
//        func getSource() -> MKMapItem? {return _currentRide.source}
//        func getDestination() -> MKMapItem? {return _currentRide.destination}
//    }
    
    struct Ride {
        var source: MKMapItem?
        var destination: MKMapItem?
    }
    
//    protocol Search {
//        associatedtype SearchItemType
//        associatedtype SearchResponseType
//        func search(_ searchItem: SearchItemType, completionHandler: ((SearchResponseType?) -> Void)?)
//    }
    
//    struct LocationSearchApiRepository: Search {
//        func search(_ searchItem: String?, completionHandler: (([MKMapItem]?) -> Void)?) {
//            // Location Search Code Using MKLocalSearch
//            // Also it will Debounce Technique
//        }
//
//        typealias SearchItemType = String?
//
//        typealias SearchResponseType = [MKMapItem]
//
//        private var _workItem: DispatchWorkItem?
//
//    }
    
//    protocol BasicRepository {
//        associatedtype T
//        func fetchAllData(completionHandler: (T?)->Void)
//    }
    
//    struct PreviousDestinationApiRepository: BasicRepository {
//        func fetchAllData(completionHandler: ([MKMapItem]?) -> Void) {
//            // Use HTTP Utility to get Previous Destinations and convert LocationArray to [MKMapItem]
//        }
//
//        typealias T = [MKMapItem]
//
//    }
    
    struct HTTPUtility {
        static func getApi<T: Decodable>(_ url: URL, type: T.Type, completionHandler: @escaping (T?)->Void) {}
    }
    
    struct Location: Decodable {
        var latitude: CLLocationDegrees
        var longitude: CLLocationDegrees
        var name: String
        var postalAddress: String
    }
    
    struct LocationArray: Decodable {
        var locations: [Location]
    }
    
}
