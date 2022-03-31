//
//  MainSceenController.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 05/02/22.
//
import MapKit
import Foundation

protocol LocationSearchProtocol: AnyObject {
    func updateLocationList(_ list: [String])
}

final class MainScreenController {
    private var destination: MKMapItem?
    private var source: MKMapItem?
    private var currentSearchResults: [MKMapItem]? {
        didSet {
            viewController?.updateLocationList(currentSearchResults?.compactMap({$0.placemark.title}) ?? [])
        }
    }
    
    private weak var viewController: LocationSearchProtocol?
    
    init(_ viewController: LocationSearchProtocol) {
        self.viewController = viewController
    }
    
    func searchLocation(_ searchString: String?){
        guard let text = searchString else {return}
        SearchManager.shared.searchLocation(text) { [weak self] response, error in
            guard error == nil, let weakSelf = self else {return}
            weakSelf.currentSearchResults = response?.mapItems
        }
    }
    
    func searchForRide() {
        guard let dst = destination else {
            NSLog("Please enter destination")
            return
        }
        guard let src = destination else {
            NSLog("Please enter destination")
            return
        }
        
    }
    
    func setLocation(at index:Int, for textFieldTag:Int){
        if let selectedItem = currentSearchResults?[index] {
            if textFieldTag == 0 {
                source = selectedItem
            } else {
                destination = selectedItem
            }
        }
    }
}
