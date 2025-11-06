//
//  SearchViewModel.swift
//  GithubSearch
//
//  Created by Iron Man on 05/11/25.
//

import Foundation

protocol SearchViewModelable: AnyObject {
    var view: SearchViewable? {get set}
    func getItemsCount() -> Int
    func getItem(for index: Int) -> SearchItem
    func search(with text: String)
    func searchNextPage()
    func cancelSearch()
    func retry()
}

class SearchViewModel {
    var view: SearchViewable?
    private var model: SearchModel
    private var apiService: ApiService
    
    enum Constants {
        static let apiPath = ""
    }
    
    init(for view: SearchViewable?, apiService: ApiService, with model: SearchModel = .init()) {
        self.view = view
        self.apiService = apiService
        self.model = model
    }
}

extension SearchViewModel: SearchViewModelable {
    func retry() {
        
    }
    
    func getItemsCount() -> Int {
        model.items.count
    }
    
    func getItem(for index: Int) -> SearchItem {
        guard index < (model.items.count) else {
            return SearchItem(login: "", url: "", avatarUrl: "", id: 0)
        }
        return model.items[index]
    }
    
    func searchNextPage() {
        
    }
    
    func search(with text: String) {
        apiService.get(path: Constants.apiPath, queries: [:], responseType: SearchModel.self) {[weak self] result in
            guard let self else {return}
            switch result {
            case .success(model):
                self.model.items.append(contentsOf: model.items)
                self.view?.updateResults()
                self.view?.showRetry(false)
            case .failure:
                view?.showRetry(true)
            default:
                break
            }
        }
    }
    
    func cancelSearch() {
        
    }
}
