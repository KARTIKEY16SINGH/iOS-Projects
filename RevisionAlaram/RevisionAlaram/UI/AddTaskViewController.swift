//
//  ViewController.swift
//  RevisionAlarm
//
//  Created by Iron Man on 27/12/25.
//

import UIKit
internal import CoreData

final class AddTaskViewController: UIViewController {
    
    private let field = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        field.placeholder = "Enter topic"
        field.borderStyle = .roundedRect
        
        let btn = UIButton(type: .system)
        btn.setTitle("Add", for: .normal)
        btn.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [field, btn])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    @objc func addTask() {
        guard let text = field.text, !text.isEmpty else { return }
        
        let task = RevisionTask(context: CoreDataStack.shared.context)
        task.id = UUID()
        task.title = text
        task.createdAt = Date()
        task.currentStep = 0
        task.isPaused = false
        task.isActive = true
        
        CoreDataStack.shared.save()
        NotificationManager.shared.scheduleNext(task: task)
        dismiss(animated: true)
    }
}
