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
    private let tableViewCellResuseIdentifier: String = "locationCell"
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
        let diffableDataSource = UITableViewDiffableDataSource<Int,LocationItem>(tableView: tableView) {[weak self] tableView, indexPath, itemIdentifier in
            guard let wSelf = self, let cell = tableView.dequeueReusableCell(withIdentifier: wSelf.tableViewCellResuseIdentifier) else {
                print("Not able to deque reusable cell")
                return nil
            }
            cell.textLabel?.text = itemIdentifier.title
            cell.detailTextLabel?.text = itemIdentifier.address
            cell.imageView?.image = UIImage(systemName: "location.fill")
            return cell
        }
        tableView.dataSource = diffableDataSource
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
