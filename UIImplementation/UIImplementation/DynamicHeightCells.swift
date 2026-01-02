//
//  DynamicHeightCells.swift
//  UIImplementation
//
//  Created by Iron Man on 02/01/26.
//

import UIKit

class DynamicHeightCellsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = 44
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        layoutTableView()
    }
    
    private func layoutTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension DynamicHeightCellsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ArticleDataSource.makeData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DynamicHeightTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? DynamicHeightTableViewCell ?? .init(style: .default, reuseIdentifier: "tableViewCell")
        cell.titleLabel.text = ArticleDataSource.makeData()[indexPath.row].description
        cell.descriptionLabel.text = ArticleDataSource.makeData()[indexPath.row].description
        
        return cell
    }
}

final class DynamicHeightTableViewCell: UITableViewCell {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        layoutLabels()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    let padding: CGFloat = 16
    
    private func layoutLabels() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}


struct Article {
    let title: String
    let description: String
}

final class ArticleDataSource {
    static func makeData() -> [Article] {
        return [
            Article(
                title: "UIKit",
                description: "UIKit is a framework that provides the required infrastructure for iOS or tvOS apps. It provides window and view architecture."
            ),
            Article(
                title: "Auto Layout",
                description: "Auto Layout dynamically calculates the size and position of all the views in your view hierarchy, based on constraints placed on those views."
            ),
            Article(
                title: "Dynamic Cells",
                description: "Dynamic height cells are a common UIKit interview problem. The correct solution relies entirely on Auto Layout and proper constraint configuration without manual height calculations."
            )
        ]
    }
}
