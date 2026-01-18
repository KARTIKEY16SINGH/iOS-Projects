//
//  ItemInfoCell.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//

import UIKit

final class ItemInfoCell: UITableViewCell {
    static let reuseIdentifier = "itemInfoCell"
    
    private let itemInfoView: ItemInfoView = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItemView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupItemView() {
        itemInfoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemInfoView)
        
        NSLayoutConstraint.activate([
            itemInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: itemInfoView.heightAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemInfoView.reset()
    }
    
    func updateItemInfoView(with model: ItemInfo, actionHandler: @escaping () -> Void) {
        itemInfoView.update(from: model, favActionHandler: actionHandler)
    }
}
