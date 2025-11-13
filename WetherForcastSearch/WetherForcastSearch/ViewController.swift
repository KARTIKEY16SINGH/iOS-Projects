//
//  ViewController.swift
//  WetherForcastSearch
//
//  Created by Iron Man on 14/11/25.
//

import UIKit

protocol SearchViewable: AnyObject {
    func updateView()
    func showError()
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar?

    var viewModel: SearchViewModelable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(text: searchText)
    }
}
