//
//  ViewController.swift
//  RevisionAlarm
//
//  Created by Iron Man on 27/12/25.
//

import UIKit
internal import CoreData

final class AddTaskViewController: UIViewController {
    
    private let titleField = UITextField()
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        titleField.placeholder = "Enter topic"
        titleField.borderStyle = .roundedRect
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        /*datePicker.minimumDate = Date() */  // no past dates
        
        let addButton = UIButton(type: .system)
        addButton.setTitle("Add Task", for: .normal)
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [
            titleField,
            datePicker,
            addButton
        ])
        
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        titleField.delegate = self
    }
    
    @objc private func addTask() {
        guard let text = titleField.text, !text.isEmpty else { return }
        
        let ctx = CoreDataStack.shared.context
        let task = RevisionTask(context: ctx)
        
        task.id = UUID()
        task.title = text
        task.createdAt = datePicker.date
        task.currentStep = 0
        task.isPaused = false
        task.isActive = true
        
        // 🔴 IMPORTANT: Use user-selected time
//        let selectedDate = datePicker.date
//        task.lastScheduledAt = selectedDate
        
        CoreDataStack.shared.save()
        NotificationManager.shared.scheduleNext(task: task)
        
        dismiss(animated: true)
    }
}

extension AddTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Hides keyboard
        return true
    }
}

