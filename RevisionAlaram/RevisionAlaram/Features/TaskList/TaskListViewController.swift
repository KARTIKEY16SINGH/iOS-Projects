//
//  TaskListViewController.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//

import UIKit
import CoreData

final class TaskListViewController: UITableViewController {
    
    private let viewModel = TaskListViewModel()
    private var tasks: [RevisionTask] = []
    private var selectedDate: Date? = nil
    
    private let filterControl = UISegmentedControl(items: ["Today", "All", "Pick Date"])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spaced Revision"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
            target: self,
            action: #selector(add))
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        
        navigationItem.titleView = filterControl
        filterControl.selectedSegmentIndex = 0
        filterControl.addTarget(
            self,
            action: #selector(filterChanged),
            for: .valueChanged
        )
        viewModel.advanceAndRescheduleMissedTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    @objc private func filterChanged() {
        switch filterControl.selectedSegmentIndex {
        case 0: // Today
            selectedDate = nil
            reload()
            
        case 1: // All
            selectedDate = nil
            reload()
            
        case 2: // Pick Date
            showDatePicker()   // ✅ CALLED HERE
            
        default:
            break
        }
    }

    
    private func showDatePicker() {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        
        let alert = UIAlertController(
            title: "Select Date",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        alert.view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            picker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            picker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20),
            picker.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -60)
        ])
        
        alert.addAction(
            UIAlertAction(title: "Show Tasks", style: .default) { _ in
                self.selectedDate = picker.date
                self.reload()
            }
        )
        
        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.filterControl.selectedSegmentIndex = 0
                self.reload()
            }
        )
        
        present(alert, animated: true)
    }

    
    private func reload() {
        switch filterControl.selectedSegmentIndex {
        case 0:
            tasks = viewModel.fetchTodayTasks()
            
        case 1:
            tasks = viewModel.fetchAllTasks()
            
        case 2:
            if let date = selectedDate {
                tasks = viewModel.fetchTasks(for: date)
            } else {
                tasks = []
            }
            
        default:
            tasks = []
        }
        debugPrint("Current Task Items")
        for task in tasks {
            print(task.readableDescription())
        }
        tableView.reloadData()
    }

    
    @objc func add() {
        navigationController?.pushViewController(AddTaskViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "TaskCell",
            for: indexPath
        ) as? TaskCell else {
            return .init()
        }

        let task = tasks[indexPath.row]
        cell.configure(task: task)
        
        cell.onPause = {
            task.isPaused = true
            NotificationManager.shared.cancel(task: task)
            CoreDataStack.shared.save()
            DispatchQueue.main.async { [weak self] in
                self?.reload()
            }
        }
        
        cell.onResume = {
            task.isPaused = false
            NotificationManager.shared.scheduleNext(task: task)
            CoreDataStack.shared.save()
            DispatchQueue.main.async { [weak self] in
                self?.reload()
            }
        }
        
        cell.onRewind = {
            task.currentStep = SpacedRevisionScheduler.rewind()
            NotificationManager.shared.cancel(task: task)
            NotificationManager.shared.scheduleNext(task: task)
            CoreDataStack.shared.save()
            DispatchQueue.main.async { [weak self] in
                self?.reload()
            }
        }
        
        cell.onDelete = {
            NotificationManager.shared.cancel(task: task)
            CoreDataStack.shared.context.delete(task)
            CoreDataStack.shared.save()
            DispatchQueue.main.async { [weak self] in
                self?.reload()
            }
        }
        
        return cell
    }
}
