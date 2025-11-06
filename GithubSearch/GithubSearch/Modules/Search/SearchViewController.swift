//
//  ViewController.swift
//  GithubSearch
//
//  Created by Iron Man on 05/11/25.
//

import UIKit

protocol SearchViewable: AnyObject {
    func updateResults()
    func showRetry(_ value: Bool)
}

final class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    private weak var retryButton: UIButton?
    
    weak var viewModel: SearchViewModelable?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar?.delegate = self
        
        let retryButton = UIButton(type: .system)
        retryButton.isHidden = true
        
        view.addSubview(retryButton)
        self.retryButton = retryButton
    }

    private func setupViewModel() {
        viewModel = SearchViewModel(for: self, apiService: ApiService())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        retryButton?.center = view.center
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidchange")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

extension SearchViewController: SearchViewable {
    func updateResults() {
        tableView?.reloadData()
    }
    
    func showRetry(_ value: Bool) {
        retryButton?.isHidden = !value
        tableView?.isHidden = value
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.getItem(for: indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") else { return .init() }
        
        cell.textLabel?.text = item.login
        cell.imageView?.setImage(from: item.avatarUrl)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
