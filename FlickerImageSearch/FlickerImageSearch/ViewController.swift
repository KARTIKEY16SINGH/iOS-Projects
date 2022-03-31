//
//  ViewController.swift
//  FlickerImageSearch
//
//  Created by Iron Man on 16/03/21.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var tabelView : UITableView!
    var totalImages = 0
    var perPage = 0
    var curPage = 0
    var reqPage = 0
    var totalPages = 0
    var currentSearchText = ""
    static var cache = [String : UIImage]()
    var imageWorkItem : DispatchWorkItem!
    var apiWorkItem : DispatchWorkItem!
    
    let bufferForAPICall = 30
    let url = URL(string : "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&%20format=json&nojsoncallback=1&safe_search=1&text=apple&page=1")!
    var photoMetaData = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.searchBar.delegate = self
        
//        NotificationCenter.default.add.addObserver(<#T##observer: Any##Any#>, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
    
    func fetchData(text : String, page : Int) {
        let session = URLSession.shared
        let url = URL(string : "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&%20format=json&nojsoncallback=1&safe_search=1&text=\(text)&page=\(page)")!
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
//                    print(json)
                    if let photos = json["photos"] as? [String : Any] {
                        if let tCount = photos["total"] as? String {
                            print("Total Images = \(tCount)")
                            self.totalImages = Int(tCount) ?? 0
                        }
                        if let pPage = photos["perpage"] as? Int {
                            print("Per Page Image = \(pPage)")
                            self.perPage = pPage
                        }
                        if let cPage = photos["page"] as? Int {
                            print("Current Page = \(cPage)")
                            self.curPage = cPage
                        }
                        if let tPages = photos["pages"] as? Int {
                            print("Total Pages = \(tPages)")
                            self.totalPages = tPages
                        }
                        if let photoArr = photos["photo"] as? [[String : Any]] {
//                                print(photoArr)
                            
                            for photo in photoArr {
                                var pic = Photo()
                                pic.farm = photo["farm"] as? Int
                                pic.server = photo["server"] as? String
                                pic.id = photo["id"] as? String
                                pic.secret = photo["secret"] as? String
                                
                                self.photoMetaData.append(pic)
                                print(pic)
                                self.makeImageURL(data: pic)
                            }
                        }

                    }
                }
                DispatchQueue.main.async {
                    self.tabelView.reloadData()
                }
            } catch let error as NSError {
                print("Error = \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func makeImageURL(data : Photo) -> String {
        let flickerURL = "https://farm\(data.farm!).static.flickr.com/\(data.server!)/\(data.id!)_\(data.secret!).jpg"
        print(flickerURL)
        return flickerURL
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        min(curPage*perPage, totalImages)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let url = makeImageURL(data: photoMetaData[indexPath.row])
        if ViewController.cache.index(forKey: url) != nil {
            cell.imageView?.image = ViewController.cache[url]
        } else {
            cell.imageView?.loadImage(url: URL(string: url))
        }
        
        if reqPage <= curPage && indexPath.row + bufferForAPICall >= min(curPage * perPage, totalImages) {
            if apiWorkItem != nil {
                apiWorkItem.cancel()
            }
            reqPage = curPage + 1
            apiWorkItem = DispatchWorkItem(block: {
                self.fetchData(text: self.currentSearchText, page: self.curPage+1)
            })
            DispatchQueue.global().async(execute: apiWorkItem)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search  = \(searchText)")
        currentSearchText = searchText
        photoMetaData.removeAll()
        totalImages = 0
        perPage = 0
        totalPages = 0
        reqPage = 1
        if imageWorkItem != nil {
            imageWorkItem.cancel()
        }
        imageWorkItem = DispatchWorkItem(block: {
            self.fetchData(text: searchText, page: 1)
        })
        
        DispatchQueue.global().async(execute: imageWorkItem)
    }
}

struct Photo {
    var id : String!
    var server : String!
    var secret : String!
    var farm : Int!
}

extension UIImageView {
    func loadImage(url : URL?) {
        guard let url = url else {return}
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                guard let sSelf = self else {return}
                print(imageData)
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        sSelf.image = image
                    }
                    guard url != nil && ViewController.cache != nil else {return}
                    ViewController.cache[url.absoluteString] = image
                }
            }
        }
    }
}
