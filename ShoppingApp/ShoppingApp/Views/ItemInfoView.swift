//
//  ItemInfoView.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//

import UIKit

final class ItemInfoView: UIView {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.tintColor, for: .normal)
        return button
    }()
    
    private var thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    private var imageDownloadTask
    
    private var tapGesture: UITapGestureRecognizer?
    private var favButtonActionHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(favoriteButton)
        addSubview(thumbnailImage)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleFavTap))
        favoriteButton.addGestureRecognizer(tapGesture)
        self.tapGesture = tapGesture
        layoutViews()
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            titleLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.titleHeight),
            
            priceLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.priceHeight),
            
            favoriteButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            favoriteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            favoriteButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: LayoutConstants.favSize),
            favoriteButton.widthAnchor.constraint(equalToConstant: LayoutConstants.favSize),
            
            thumbnailImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            thumbnailImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            thumbnailImage.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor),
            thumbnailImage.widthAnchor.constraint(equalToConstant: LayoutConstants.iamgeSize.width),
            thumbnailImage.heightAnchor.constraint(equalToConstant: LayoutConstants.iamgeSize.height),
            thumbnailImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func reset() {
        updateVisibility(hidden: true)
        favButtonActionHandler = nil
    }
    
    private func updateVisibility(hidden: Bool) {
        titleLabel.isHidden = hidden
        priceLabel.isHidden = hidden
        favoriteButton.isHidden = hidden
        thumbnailImage.isHidden = hidden
    }
    
    func update(from model: ItemInfo, favActionHandler: @escaping () -> Void ) {
        titleLabel.text = model.title
        priceLabel.text = "\(model.price)"
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.setImage(UIImage(systemName: (model.isFav ?? false ) ? "heart.fill" : "heart"), for: .normal)
        updateVisibility(hidden: false)
        favButtonActionHandler = favActionHandler
    }
    
    @objc
    private func handleFavTap() {
        favButtonActionHandler?()
    }
}

extension ItemInfoView {
    enum LayoutConstants {
        static let titleHeight: CGFloat = 40
        static let iamgeSize: CGSize = .init(width: 40, height: 60)
        static let priceHeight: CGFloat = 40
        static let favSize: CGFloat = 40
    }
}
