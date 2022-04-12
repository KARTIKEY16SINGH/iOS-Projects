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
        viewModel = MainScreenViewModel()
        viewModel.getPreviousDestinations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPickUpLocation()
    }
    
    @IBAction func searchButtonClicked() {}
    func updatePickupOnMapView(_ pickUp: MKMapItem) {}
}
