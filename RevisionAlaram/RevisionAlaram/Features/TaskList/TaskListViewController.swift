//
//  TaskListViewController.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//

import UIKit
import CoreData

final class TaskListViewController: UITableViewController {
    
    private var tasks: [RevisionTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spaced Revision"
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .add,
                        target: self,
                        action: #selector(add))
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    func reload() {
        let req: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
        tasks = (try? CoreDataStack.shared.context.fetch(req)) ?? []
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
        }
        
        cell.onResume = {
            task.isPaused = false
            NotificationManager.shared.scheduleNext(task: task)
            CoreDataStack.shared.save()
        }
        
        cell.onRewind = {
            task.currentStep = SpacedRevisionScheduler.rewind()
            NotificationManager.shared.cancel(task: task)
            NotificationManager.shared.scheduleNext(task: task)
            CoreDataStack.shared.save()
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
