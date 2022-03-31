//
//  ViewController.swift
//  MovieList
//
//  Created by Iron Man on 21/05/21.
//

//http://www.omdbapi.com/?apikey=dcc8fcb2&s=Avenger&page=1

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieData = [MovieListModel]()
    var manager = MovieManager.shared
    
    var currSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController : UISearchBarDelegate {
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        if let searchText = searchBar.text, searchText != "" {
//            manager.searchMovie(text: searchText) { [weak self, searchText] model in
//                guard let _ = self else {return}
//                if let data = model.search {
//                    if searchText == self!.currSearchText {
//                        self!.movieData.append(contentsOf: data)
//                    } else {
//                        self!.currSearchText = searchText
//                        self!.movieData = data
//                    }
//                    self!.tableView.reloadData()
//                } else {
//                    GUIManager.showAlert(title: "Error", message: model.error ?? "", presenter: self!)
//                }
//            }
//        }
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, searchText != "" {
            manager.searchMovie(text: searchText) { [weak self, searchText] model in
                guard let _ = self else {return}
                if let data = model.search {
                    if searchText == self!.currSearchText {
                        self!.movieData.append(contentsOf: data)
                    } else {
                        self!.currSearchText = searchText
                        self!.movieData = data
                    }
                    DispatchQueue.main.async {
                        self!.tableView.reloadData()
                    }
                } else {
                    GUIManager.showAlert(title: "Error", message: model.error ?? "", presenter: self!)
                }
            }
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell", for: indexPath) as? MovieTableViewCell {
            cell.name.text = movieData[indexPath.row].title
            manager.getImage(url: movieData[indexPath.row].imageURL) { (data) in
                DispatchQueue.main.async {
                    cell.icon?.image = UIImage(data: data)
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        manager.setIMDB(movieData[indexPath.row].imdbID)
        let sb = UIStoryboard(name: "DetailStoryBoard", bundle: Bundle(for: ViewController.self))
        if let vc = sb.instantiateInitialViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

