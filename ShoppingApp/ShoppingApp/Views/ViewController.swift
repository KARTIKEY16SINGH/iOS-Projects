//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//

import UIKit

protocol HomeViewable: AnyObject {
    var viewModel: HomeViewModelable? {get}
    func handle(action: HomeViewActions)
}

enum HomeViewActions {
    case dataUpdated
    case errorReceived
}

final class ViewController: UIViewController {
    var viewModel: HomeViewModelable?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 44
        return tableView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var errorLabelHeightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = HomeViewModel(homeInteractable: HomeUseCase(apiService: APIService()))
        viewModel?.view = self
        setupViews()
        viewModel?.handle(action: .viewDidLoad)
    }

    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        
        searchBar.delegate = self
        tableView.dataSource = self
        
        tableView.register(ItemInfoCell.self, forCellReuseIdentifier: ItemInfoCell.reuseIdentifier)
        
        layoutViews()
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: LayoutConstants.searchBarHeight),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        errorLabelHeightConstraint = errorLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.errorLabelHeight)
        errorLabelHeightConstraint?.isActive = true
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.handle(action: .search(text: searchText))
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.getNumberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getNumberOfItems(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.getItem(for: indexPath.section, row: indexPath.row) else { return .init() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemInfoCell.reuseIdentifier) as? ItemInfoCell ?? .init(style: .default, reuseIdentifier: ItemInfoCell.reuseIdentifier)
        
        cell.updateItemInfoView(with: item) {[weak self] in
            self?.viewModel?.handle(action: .toggleFav(section: indexPath.section, row: indexPath.row))
        }
        return cell
    }
    
}

extension ViewController: HomeViewable {
    func handle(action: HomeViewActions) {
        switch action {
        case .dataUpdated:
            tableView.reloadData()
            errorLabelHeightConstraint?.constant = 0
        case .errorReceived:
            errorLabelHeightConstraint?.constant = 40
        }
    }
}


extension ViewController {
    enum LayoutConstants {
        static let searchBarHeight: CGFloat = 40
        static let errorLabelHeight: CGFloat = 40
    }
}
