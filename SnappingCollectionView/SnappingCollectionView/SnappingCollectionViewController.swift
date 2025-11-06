//
//  SnappingCollectionViewController.swift
//  SnappingCollectionView
//
//  Created by Iron Man on 01/11/25.
//

import UIKit

// SnappingCollectionView.swift
// Minimal, production-ready example of a horizontally snapping collection view
// Uses UICollectionViewCompositionalLayout + Diffable Data Source

final class SnappingCollectionViewController: UIViewController {
    enum Section { case main }
    struct Item: Hashable {
        let id = UUID()
        let title: String
        let color: UIColor
    }

    private lazy var collectionView: UICollectionView = {
        let layout = Self.makeLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .systemBackground
        cv.decelerationRate = .fast // small UX improvement for snappy feeling
        cv.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        return cv
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        let ds = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else { return nil }
            cell.configure(title: item.title, color: item.color)
            return cell
        }
        return ds
    }()

    private var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Snapping Collection"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 260)
        ])

        applyInitialSnapshot()
    }

    private func applyInitialSnapshot() {
        // sample data
        items = [
            Item(title: "One", color: .systemRed),
            Item(title: "Two", color: .systemBlue),
            Item(title: "Three", color: .systemGreen),
            Item(title: "Four", color: .systemOrange),
            Item(title: "Five", color: .systemPurple)
        ]

        var snap = NSDiffableDataSourceSnapshot<Section, Item>()
        snap.appendSections([.main])
        snap.appendItems(items, toSection: .main)
        dataSource.apply(snap, animatingDifferences: false)
    }

    // MARK: - Layout
    private static func makeLayout() -> UICollectionViewLayout {
        // Item fills group's height and width
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // Group width is 80% of the collectionView width. This creates peeking effect for neighboring cells.
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging //.groupPagingCentered // <-- snapping behavior
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - CardCell
final class CardCell: UICollectionViewCell {
    static let reuseIdentifier = "CardCell"

    private let cardView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 14
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .preferredFont(forTextStyle: .title2)
        l.textAlignment = .center
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontForContentSizeCategory = true
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)

        // subtle shadow
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.12
        contentView.layer.shadowRadius = 8
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.masksToBounds = false

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: cardView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        cardView.backgroundColor = nil
    }

    func configure(title: String, color: UIColor) {
        titleLabel.text = title
        cardView.backgroundColor = color
        // Accessibility
        accessibilityLabel = title
        isAccessibilityElement = true
    }
}

// MARK: - Usage
// To present in your app, instantiate SnappingCollectionViewController and push/present it.
// Example:
// let vc = SnappingCollectionViewController()
// navigationController?.pushViewController(vc, animated: true)

// If you'd prefer a FlowLayout-based snapping implementation (supports older iOS versions),
// tell me and I'll add it. This compositional layout works best on iOS 13+.
