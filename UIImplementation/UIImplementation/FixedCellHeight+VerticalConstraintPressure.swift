//
//  FixedCellHeight+VerticalConstraintPressure.swift
//  UIImplementation
//
//  Created by Iron Man on 02/01/26.
//

import UIKit

final class FixedHeightCellsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = 80
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

extension FixedHeightCellsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MessageDataSource.makeData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FixedHeightTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? FixedHeightTableViewCell ?? .init(style: .default, reuseIdentifier: "tableViewCell")
        cell.titleLabel.text = MessageDataSource.makeData()[indexPath.row].title
        cell.descriptionLabel.text = MessageDataSource.makeData()[indexPath.row].subtitle
        
        return cell
    }
}

final class FixedHeightTableViewCell: UITableViewCell {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    let padding: CGFloat = 8
    let spacing: CGFloat = 4
    
    private func layoutLabels() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
}

struct Message {
    let title: String
    let subtitle: String
}

final class MessageDataSource {
    static func makeData() -> [Message] {
        return [
            Message(
                title: "Important",
                subtitle: "This subtitle is short."
            ),
            Message(
                title: "System Warning",
                subtitle: "This subtitle is intentionally very long to force vertical compression inside a fixed height table view cell so that Auto Layout priorities actually matter."
            )
        ]
    }
}
