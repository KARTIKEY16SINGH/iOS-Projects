//
//  SearchViewModel.swift
//  WetherForcastSearch
//
//  Created by Iron Man on 14/11/25.
//

import Foundation

protocol SearchViewModelable {
    func search(text: String)
    func numberOfRowsInSection() -> Int
    func getItemForRow(at index: IndexPath) -> SearchDailyDataSourceItem
}

class SearchViewModel: SearchViewModelable {
    weak var view: SearchViewable?
    
    private var cityModal: CityModal?
    private var forecastModal: ForecastModel?
    
    private var currentDataTasks: [URLSessionDataTask?] = []
    private var cityApiOperation: BlockOperation?
    private var forecastApiOperation: BlockOperation?
    private var apiServicable: ApiServicable
    private let queue: OperationQueue
    init(apiServicable: ApiServicable, operationQueue: OperationQueue = .init()) {
        self.apiServicable = apiServicable
        self.queue = operationQueue
    }

}

extension SearchViewModel {
    func numberOfRowsInSection() -> Int {
        forecastModal?.dailyWeatherInfo.temperatureMax.count ?? 0
    }
    
    func getItemForRow(at index: IndexPath) -> SearchDailyDataSourceItem {
        
    }
    
    func search(text: String) {
        currentDataTasks.forEach { $0?.cancel() }
        currentDataTasks = []
        cityApiOperation?.cancel()
        forecastApiOperation?.cancel()
        
        let cityRequest = ApiRequest(path: Constants.cityApiUrl, queryParams: [:])
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let cityApiOperation = BlockOperation(block: { [weak self] in
            let task = self?.apiServicable.get(request: cityRequest, type: CityModal.self) {[weak self] result in
                guard let weakSelf = self else {return}
                switch result {
                case let .success(data):
                    weakSelf.cityModal = data
                case .failure:
                    weakSelf.forecastApiOperation?.cancel()
                    weakSelf.view?.showError()
                }
                dispatchGroup.leave()
            }
            
            self?.currentDataTasks.append(task)
        })
        
        
        dispatchGroup.enter()
        let forecastApiOperation = BlockOperation { [weak self] in
            let forecastRequest = ApiRequest(path: Constants.forecastApiUrl, queryParams: [:])
            let task = self?.apiServicable.get(request: forecastRequest, type: ForecastModel.self) { result in
                guard let weakSelf = self else {return}
                switch result {
                case let .success(data):
                    weakSelf.forecastModal = data
                case .failure:
                    weakSelf.view?.showError()
                }
                dispatchGroup.leave()
            }
            
            self?.currentDataTasks.append(task)
        }
        
        forecastApiOperation.addDependency(cityApiOperation)
        self.cityApiOperation = cityApiOperation
        self.forecastApiOperation = forecastApiOperation
        queue.addOperations([cityApiOperation, forecastApiOperation], waitUntilFinished: true)
    }
}

extension SearchViewModel {
    enum Constants {
        static let cityApiUrl: String = "https://geocoding-api.open-meteo.com/v1/search"
        static let forecastApiUrl: String = "https://api.open-meteo.com/v1/forecast"
    }
}
