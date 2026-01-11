//
//  TaskCell.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//

import UIKit

final class TaskCell: UITableViewCell {
    
    // MARK: - Callbacks (UI → VC / VM)
    var onPause: (() -> Void)?
    var onResume: (() -> Void)?
    var onRewind: (() -> Void)?
    var onDelete: (() -> Void)?
    var onNext: (() -> Void)?
    
    // MARK: - UI Elements
    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⋯", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let accessoryContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init (IMPORTANT)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupAccessory()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupAccessory() {
        accessoryContainer.addSubview(menuButton)
        contentView.addSubview(accessoryContainer)
//        accessoryType = .detailButton
//        accessoryView = accessoryContainer
        NSLayoutConstraint.activate([
            menuButton.leftAnchor.constraint(equalTo: accessoryContainer.leftAnchor, constant: 0),
            menuButton.rightAnchor.constraint(equalTo: accessoryContainer.rightAnchor, constant: 0),
            menuButton.topAnchor.constraint(equalTo: accessoryContainer.topAnchor, constant: 0),
            menuButton.bottomAnchor.constraint(equalTo: accessoryContainer.bottomAnchor, constant: 0),
            menuButton.widthAnchor.constraint(equalTo: accessoryContainer.widthAnchor),
            menuButton.heightAnchor.constraint(equalTo: accessoryContainer.heightAnchor),
            
            accessoryContainer.widthAnchor.constraint(equalToConstant: 44),
            accessoryContainer.heightAnchor.constraint(equalToConstant: 44),
//            accessoryContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            accessoryContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
//        accessoryView = accessoryContainer
    }
    
    // MARK: - Configuration
    func configure(task: RevisionTask) {
        textLabel?.text = task.title ?? "(Untitled)"
        
        let menu = UIMenu(children: [
            UIAction(title: "Pause") { [weak self] _ in
                self?.onPause?()
            },
            UIAction(title: "Resume") { [weak self] _ in
                self?.onResume?()
            },
            UIAction(title: "Rewind") { [weak self] _ in
                self?.onRewind?()
            },
            UIAction(title:"Delete") { [weak self] _ in
                self?.onDelete?()
            },
            UIAction(title:"Next") { [weak self] _ in
                self?.onNext?()
            }
        ])
        
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        onPause = nil
        onResume = nil
        onRewind = nil
    }
}

