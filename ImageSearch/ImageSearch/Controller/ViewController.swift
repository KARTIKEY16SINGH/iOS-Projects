//
//  ViewController.swift
//  ImageSearch
//
//  Created by Iron Man on 18/05/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    var manager : Manager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = Manager(handler: { [weak self] in
            self?.tableView.reloadData()
        })
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
        searchBar.delegate = self
        tableView.delegate = self
    }


}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("[Search] TextDidChange = \(searchText)")
        manager.searchedTextChanged(searchText)
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        manager.getImage(index: indexPath.row) { [weak cell] (data) in
            cell?.imageView?.image = UIImage(data: data)
        }
        return cell ?? UITableViewCell()
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.numberOfRows(inSection: indexPath.section) - 1 == indexPath.row {
            manager.fetchNextPage()
        }
    }
}
