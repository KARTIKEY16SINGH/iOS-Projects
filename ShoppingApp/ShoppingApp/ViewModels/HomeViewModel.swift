//
//  SearchBarViewModel.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//

import Foundation

protocol HomeViewModelable {
    var view: HomeViewable? {get set}
    func handle(action: HomeActions)
    func getNumberOfSection() -> Int
    func getItem(for section: Int, row: Int) -> ItemInfo?
    func getNumberOfItems(in section: Int) -> Int
}

enum HomeActions {
    case viewDidLoad
    case search(text: String)
    case cellSelected(section: Int, row: Int)
    case toggleFav(section: Int, row: Int)
}


final class HomeViewModel {
    weak var view: HomeViewable?
    private let homeInteractable: HomeInteractable
    
    private var filteredItems: [ItemInfo] = []
    private var favItems: [ItemInfo] = []
    
    init(homeInteractable: HomeInteractable) {
        self.homeInteractable = homeInteractable
        self.homeInteractable.setDelegate(self)
    }
}

extension HomeViewModel: HomeViewModelable {
    func handle(action: HomeActions) {
        switch action {
        case .viewDidLoad:
            homeInteractable.fetchFavItems()
        case .search(let text):
            homeInteractable.search(text: text)
        case .cellSelected(let section, let row):
            return
        case .toggleFav(let section, let row):
            homeInteractable.updateFav(for: favItems[row])
        }
    }
    
    private var dataSource: [[ItemInfo]] {
        [filteredItems, favItems]
    }
    
    func getNumberOfSection() -> Int {
        dataSource.count
    }
    
    func getItem(for section: Int, row: Int) -> ItemInfo? {
        dataSource[section][row]
    }
    
    func getNumberOfItems(in section: Int) -> Int {
        dataSource[section].count
    }
}

extension HomeViewModel: HomeInteractableDelegate {
    func handle(action: HomeInteractableDelegateActions) {
        let viewAction: HomeViewActions
        switch action {
        case .receivedApiData(let array):
            filteredItems = array
            viewAction =  .dataUpdated
        case .receivedCachedData(let array):
            favItems = array
            viewAction =  .dataUpdated
        case .receivedApiError(let apiError):
            viewAction = .errorReceived
        case .receivedCacheError:
            viewAction = .errorReceived
        }
        DispatchQueue.main.async { [weak self] in
            self?.view?.handle(action: viewAction)
        }
    }
}
