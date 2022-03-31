//
//  ViewController.swift
//  Serach
//
//  Created by Iron Man on 30/03/22.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = SearchViewModel(self)
        viewModel?.newSearchTextEntered("abc")
    }
    
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellData = viewModel?.getCellData(indexPath.row) {
            let cell = UITableViewCell()
            cell.textLabel?.text = cellData.title
            cell.detailTextLabel?.text = cellData.description
            return cell
        }
        return UITableViewCell()
        // cell creation
    }
    
    
}

extension ViewController: SearchView {
    func receivedSearchResponse() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func failedToReceiveSearchResponse() {
        // show alert
    }
}

protocol SearchView: AnyObject {
    func receivedSearchResponse()
    func failedToReceiveSearchResponse()
}

class SearchViewModel {
    private let _searchApiRepository = SearchAPIReporsitory()
    private var _workItem: DispatchWorkItem?
    private weak var view: SearchView?
    private var _searchResponse: [Item]?
    
    init(_ view: SearchView) {
        self.view = view
    }
    
    func newSearchTextEntered(_ str: String) {
        if _workItem != nil {
            _workItem?.cancel()
        }
        
        _workItem = DispatchWorkItem(block: { [weak self] in
            if self?._workItem?.isCancelled == true {
                return
            }
            self?._searchApiRepository.getSearchResponse(str) { response in
                if self?._workItem?.isCancelled == true {
                    return
                }
                if let resp = response {
                    self?._searchResponse = resp.items
                    self?.view?.receivedSearchResponse()
                } else {
                    self?.view?.failedToReceiveSearchResponse()
                }
            }
        })
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: _workItem!)
    }
    
    func getNumberOfItems() -> Int {
        return _searchResponse?.count ?? 0
    }
    
    func getCellData(_ index: Int) -> (title: String, image: String, description: String) {
        // check for index
        let data = _searchResponse![index]
        return (data.title, data.thumbnail, data.decriptiom)
    }
}

struct SearchAPIReporsitory {
    let searchUrlString = "searchUrl"
    func getSearchResponse(_ str: String, completionHandler: ((SearchResponse?) -> Void)?) {
        if let url = URL(string: searchUrlString) {
            HTTPUTitlity.getApi(url: url, type: SearchResponse.self, completionHandler: completionHandler)
        }
    }
}

struct RecentSearchCDRepository {
    
}


struct HTTPUTitlity {
    static func getApi<T:Decodable>(url: URL, type: T.Type?, completionHandler: ((T?) -> Void)?) {
        //URL Session Code
        
        let dummyJSON = """
        {
            "items": [
                {
                    "id": 1,
                    "title": "Some Product A",
                    "decriptiom": "Some Product A decp",
                    "itemUrl": "itemUrl A",
                    "thumbnail": "thumbnail url A"
                },
                        {
                            "id": 2,
                            "title": "Some Product b",
                            "decriptiom": "Some Product b decp",
                            "itemUrl": "itemUrl b",
                            "thumbnail": "thumbnail url b"
                        },
                        {
                            "id": 3,
                            "title": "Some Product c",
                            "decriptiom": "Some Product c decp",
                            "itemUrl": "itemUrl c",
                            "thumbnail": "thumbnail url c"
                        }
        ]
        }
        """
        
        let data = dummyJSON.data(using: .utf8)!
        guard let type = type else {return}
        do {
            let decodedResponse = try JSONDecoder().decode(type.self, from: data)
            completionHandler?(decodedResponse)
        } catch let error {
            debugPrint(error)
            completionHandler?(nil)
        }
    }
}

struct Item: Decodable {
    var id: Int
    var title: String
    var decriptiom: String
    var itemUrl: String
    var thumbnail: String
}

struct SearchResponse: Decodable {
    var items: [Item]
}

class RecentSearchEntity: NSManagedObject {
    var id: UUID?
    var searchTitle: String?
//    var toSearch:
}
