//
//  LocationModels.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 05/02/22.
//
import MapKit
import Foundation

//struct Ride {
//    let destination: MKMapItem
//    let source: MKMapItem
//    let user: String
//    var driver: String
//    
//    init(_ dst: MKMapItem, _ src: MKMapItem) {
//        destination = dst
//        source = src
//        user = ""
//        driver = ""
//    }
//}

struct Location: Decodable {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var name: String
    var postalAddress: String
}

struct LocationArray: Decodable {
    var locations: [Location]
}
