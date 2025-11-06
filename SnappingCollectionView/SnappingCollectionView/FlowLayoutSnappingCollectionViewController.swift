//
//  FlowLayoutSnappingCollectionViewController.swift
//  SnappingCollectionView
//
//  Created by Iron Man on 01/11/25.
//

import UIKit

// FlowLayoutSnappingCollectionView.swift
// Snapping Collection View for older iOS versions using UICollectionViewFlowLayout

final class FlowLayoutSnappingCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    struct Item: Hashable {
        let id = UUID()
        let title: String
        let color: UIColor
    }

    private lazy var collectionView: UICollectionView = {
        let layout = SnappingFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .systemBackground
        cv.decelerationRate = .fast
        cv.delegate = self
        cv.dataSource = self
        cv.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        return cv
    }()

    private var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FlowLayout Snapping"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 260)
        ])

        populateItems()
    }

    private func populateItems() {
        items = [
            Item(title: "One", color: .systemRed),
            Item(title: "Two", color: .systemBlue),
            Item(title: "Three", color: .systemGreen),
            Item(title: "Four", color: .systemOrange),
            Item(title: "Five", color: .systemPurple)
        ]
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension FlowLayoutSnappingCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else { return UICollectionViewCell() }
        let item = items[indexPath.item]
        cell.configure(title: item.title, color: item.color)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FlowLayoutSnappingCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.8, height: 220)
    }
}

// MARK: - SnappingFlowLayout
final class SnappingFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let targetRect = CGRect(origin: CGPoint(x: proposedContentOffset.x, y: 0), size: collectionView.bounds.size)
        guard let layoutAttributes = super.layoutAttributesForElements(in: targetRect) else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let horizontalCenter = proposedContentOffset.x + collectionView.bounds.width / 2
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude

        for attributes in layoutAttributes {
            let itemCenter = attributes.center.x
            if abs(itemCenter - horizontalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = itemCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}

// MARK: - Usage
// To present:
// let vc = FlowLayoutSnappingCollectionViewController()
// navigationController?.pushViewController(vc, animated: true)

