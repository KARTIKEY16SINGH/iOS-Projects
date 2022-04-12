import UIKit
import CoreLocation
/*
 Fetch User Current Location
 Fetch Restaurant Lists
 Filter out restaurants that are in 2KM radius
 Display the filtered restaurant list on view
 MVVM
 Repository Pattern
*/

struct MALocationManager {
    private let manager: CLLocationManager?
    init() {
        manager = CLLocationManager()
    }
    func fetchCurrentLocation() {} // Will Return Current Locaiton of user
}

struct RestaurantsApiRepository {
    private let httpUtitlity: HTTPUtility
    init() {
        httpUtitlity = HTTPUtility()
    }
    private let api = "" // some url
    func fetchRestaurantList(completionHandler: ([Restaurant]?) -> Void) {
        let url = URL(string: api)!
        httpUtitlity.getApi(url: url, type: Restaurant.self, completionHandler: completionHandler)
    }
}

class RestaurantVC {
    private var viewModel : RestaurantViewModel!
}

// extension RestaurantVC : UITableViewDataSource
// extension RestaurantVC: RestaurantScreen

protocol RestaurantScreen: AnyObject {
    func receivedRestaurantList()
    func failedToReceiveList()
}

struct RestaurantModelForView {
    var name: String
    var address: String
    var rating: Float
}

struct RestaurantViewModel {
    private weak var view : RestaurantScreen?
    private var currentLocation: CLLocation?
    private var restaurantList: [Restaurant]?
    private let locationManager: MALocationManager
    private let restaurantApiRepository: RestaurantsApiRepository
    
    init(_ view: RestaurantScreen) {
        self.view = view
        locationManager = MALocationManager()
        restaurantApiRepository = RestaurantsApiRepository()
    }
    
    func getCurrentLocation() {}
    func getRestaurantLists() {
        restaurantApiRepository.fetchRestaurantList { restaurants in
            if restaurants == nil {
                // error
            } else if restaurants?.count == 0 {
                // not any restaurant for current location
                
            } else {
                view?.receivedRestaurantList()
            }
        }
    }
    private func filterRestaurants(_ list: [Restaurant]) {} // it will return filtered list
    
    func getNumberOfRestaurants() -> Int {0}
    func getRestaurant(forIndex index: Int)  {} // It will return RestaurantModelForView
    func selectRestaurant(atIndex index: Int) {}
}



struct HTTPUtility {
    func getApi<T:Decodable>(url: URL, type: T.Type, completionHandler: (T?) -> Void) {
        
    }
}

struct Restaurant: Decodable {
    var id: UUID
    var name: String
    var address: String
    var location: Coordinates
    var rating: Float
}

struct Coordinates: Decodable {
    var latitude: Double
    var longitude: Double
}
"""
{
    "id": 890849,
"name": HIUu
}
"""
