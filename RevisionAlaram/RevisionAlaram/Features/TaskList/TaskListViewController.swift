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
    
    private let filterControl = UISegmentedControl(items: ["Today", "All"])

    
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
        reload()
    }
    
    private func reload() {
        if filterControl.selectedSegmentIndex == 0 {
            tasks = viewModel.fetchTodayTasks()
        } else {
            tasks = viewModel.fetchAllTasks()
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
