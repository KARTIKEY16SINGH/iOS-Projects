//
//  ViewController.swift
//  Dunzo
//
//  Created by Iron Man on 16/03/22.
//

// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=26c0c3fa6ccd4f5a9e8d8836d6f52e5d


import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: [ArticleForView] = []
    
    private let cellIdentifier = "newsTableViewCell"
    
    private var viewModel: NewsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = NewsViewModel(self)
//        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: Bundle(for: ViewController.self)), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
        viewModel.getNews()
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? NewsTableViewCell else {
            debugPrint("Cell dequing failed")
            return UITableViewCell()
        }
        cell.newsTitle?.text = dataSource[indexPath.row].title
        cell.newsSubtitle?.text = dataSource[indexPath.row].subtitle
        cell.newsImage?.loadImage(imageUrl: dataSource[indexPath.row].imageURL)
        return cell
    }
    
    
}

extension ViewController: NewsView {
    func receivedNews(_ articles: [ArticleForView]) {
        dataSource = articles
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func failedToReceiveArticle() {
        
    }
    
    
}
