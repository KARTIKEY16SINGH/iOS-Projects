//
//  HomeUseCase.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//

protocol HomeInteractable {
    func search(text: String)
    func fetchFavItems()
    func setDelegate(_ delegate: HomeInteractableDelegate?)
    func updateFav(for item: ItemInfo)
}

protocol HomeInteractableDelegate {
    func handle(action: HomeInteractableDelegateActions)
}

enum HomeInteractableDelegateActions {
    case receivedApiData([ItemInfo])
    case receivedCachedData([ItemInfo])
    case receivedApiError(ApiError)
    case receivedCacheError
}

final class HomeUseCase: HomeInteractable {
    private var delegate: HomeInteractableDelegate?
    private let apiService: ApiServicable
    
    init(apiService: ApiServicable) {
        self.apiService = apiService
    }
    
    func search(text: String) {
        apiService.fetch(url: UseCaseConstants.url, type: [ItemInfo].self) { [weak self] result in
            switch result {
            case .success(let data):
                let filterData = data.filter { $0.title.contains(text) }
                self?.delegate?.handle(action: .receivedApiData(filterData))
            case .failure(let failure):
                self?.delegate?.handle(action: .receivedApiError(failure))
            }
        }
    }
    
    func fetchFavItems() {
        
    }
    
    func setDelegate(_ delegate: (any HomeInteractableDelegate)?) {
        self.delegate = delegate
    }
    
    func updateFav(for item: ItemInfo) {
        
    }
}

extension HomeUseCase {
    enum UseCaseConstants {
        static let url: String = "https://fakestoreapi.com/products"
    }
}
