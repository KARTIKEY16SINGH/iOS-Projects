//
//  DynamicCollectionGridViewController.swift
//  UIImplementation
//
//  Created by Iron Man on 14/01/26.
//

import UIKit

class DynamicCollectionGridViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = LayoutConstants.padding
        flowLayout.minimumLineSpacing = LayoutConstants.padding
        flowLayout.sectionInset = .init(top: LayoutConstants.padding, left: LayoutConstants.padding, bottom: LayoutConstants.padding, right: LayoutConstants.padding)
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let dataSource: [Photo] = PhotoDataSource.makeData()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dynamic Collection View Grid"
        // Do any additional setup after loading the view.
        setupCollectionView()
        
        registerForTraitChanges([UITraitHorizontalSizeClass.self, UITraitVerticalSizeClass.self]) { [weak self] (_: UIViewController, _: UITraitCollection) in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "cell")
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        
//        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
//            collectionView.collectionViewLayout.invalidateLayout()
//        }
//    }
}

extension DynamicCollectionGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewListCell ?? .init()
        cell.contentView.backgroundColor = .red
        return cell
    }
}

extension DynamicCollectionGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItem: CGFloat
        if UIDevice.current.orientation.isPortrait {
            numberOfItem = 3
        } else {
            numberOfItem = 2
        }
        
        // 8 + x + 8 + x + 8 = y
        // 2x = y - (3*8)
        // x = (y - (3*8))/2
        // 8 + x + 8 + x + 8 + x + 8 = y
        // 3x = y - (4*8)
        // x = (y - (4*8))/3
        
        let paddingSpace = (numberOfItem + 1) * LayoutConstants.padding
        let availableWidth = collectionView.bounds.width - paddingSpace
        let cellWidth = availableWidth / numberOfItem
        debugPrint("Orientation - \(UIDevice.current.orientation.isPortrait)","Cell Width -> \(cellWidth)")
        return .init(width: cellWidth, height: LayoutConstants.height)
    }
    
    enum LayoutConstants {
        static let padding: CGFloat = 8
        static let height: CGFloat = 120
    }
}


struct Photo {
    let title: String
}

enum PhotoDataSource {
    static func makeData() -> [Photo] {
        return (1...30).map { Photo(title: "Photo \($0)") }
    }
}
