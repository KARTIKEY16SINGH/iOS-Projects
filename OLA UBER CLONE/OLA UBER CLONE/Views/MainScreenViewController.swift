//
//  MainScreenViewController.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 09/04/22.
//

import UIKit
import MapKit

class MainScreenViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchDestButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    private var viewModel: MainScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainScreenViewModel(self)
        viewModel.getPickUpLocation()
        viewModel.getPreviousDestinations()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPickUpLocation()
    }
    
    @IBAction func searchButtonClicked() {}
    func updatePickupOnMapView(_ pickUp: MKMapItem) {}
    
    private func setup() {
        setupTableView()
        setupMapView()
    }
    
    private func setupTableView() {
//        tableView.dataSource =
        tableView.tableFooterView = UIView(frame: .zero)
        let diffableDataSource = UITableViewDiffableDataSource<Int,MKMapItem>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            <#code#>
        }
    }
    
    private func setupMapView() {
//        mapView.setUserTrackingMode(.follow, animated: true)
//        mapView.showsUserLocation = true
    }
}

extension MainScreenViewController : MainScreen {
    func navigateToSeachScreen() {
        
    }
    
    func receivedPreviousDestination() {
        
    }
    
    func failedToReceivePreviousDestination() {
        
    }
    
    func navigateToBooking() {
        
    }
    
    func receivedSourceLocation(_ pickUp: MKMapItem) {
        
    }
}
