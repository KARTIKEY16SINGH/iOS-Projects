//
//  NewsAPIHandler.swift
//  Dunzo
//
//  Created by Iron Man on 16/03/22.
//

import Foundation

protocol NewsView: AnyObject {
    func receivedNews(_ articles:[ArticleForView])
    func failedToReceiveArticle()
}

struct NewsViewModel {
    weak var newsView: NewsView?
    private let newsapi = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=26c0c3fa6ccd4f5a9e8d8836d6f52e5d"
    init(_ view: NewsView) {
        newsView = view
    }
    func getNews() {
        DispatchQueue.global(qos: .default).async {
            if let url = URL(string: newsapi) {
                HTTPUtility.getDataFromApi(url: url, returnType: NewsModel.self) { newsModel in
                    guard let newsModel = newsModel else {
                        newsView?.failedToReceiveArticle()
                        return
                    }
                    let viewModel = newsModel.articles.compactMap { article -> ArticleForView in
                        let subtitle: String = (article.content ?? "") + "\n" + (article.description ?? "")
                        return ArticleForView(title: article.title ?? "", imageURL: article.urlToImage ?? "", subtitle: subtitle)
                    }
                    newsView?.receivedNews(viewModel)
                }
            }
        }
    }
}
