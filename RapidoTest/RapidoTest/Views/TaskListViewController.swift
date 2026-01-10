//
//  TaskListViewController.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import UIKit


protocol TaskViewable: AnyObject {
    func dataUpdated()
    func addedTask()
}

final class TaskListViewController: UIViewController {
    private var viewModel: TaskViewModelable?
    private var addTaskControllerType: AddTaskViewable.Type?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIKit Task List"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addTaskTapped))
        setupTableView()
        viewModel?.handle(action: .viewLoaded)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        layoutViews()
    }
    
    @objc
    private func addTaskTapped() {
        debugPrint("Add buttont tapped")
        guard let controller = addTaskControllerType?.init() else {
            debugPrint("returning from guard")
            return
        }
        controller.addButtonCallback = { [weak self] title, description in
            self?.addTask(title: title, description: description)
        }
        present(controller, animated: true)
    }
    
    private func addTask(title: String?, description: String?) {
        viewModel?.handle(action: .addTask(title: title, description: description))
    }
    
    func build(with viewModel: TaskViewModelable?, addTaskControllerType: AddTaskViewable.Type?) {
        self.viewModel = viewModel
        self.addTaskControllerType = addTaskControllerType
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell"),let item = viewModel?.getItem(for: indexPath.row) else {
            return .init()
        }
        
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText = item.decription
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel?.handle(action: .delete(index: indexPath.row))
        default:
            return
        }
    }
}

extension TaskListViewController: TaskViewable {
    func dataUpdated() {
        tableView.reloadData()
    }
    
    func addedTask() {
        dismiss(animated: true)
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.init(style: .destructive, title: "Delete") {[weak self, indexPath] _, _, completion in
            self?.viewModel?.handle(action: .delete(index: indexPath.row))
            completion(true)
        }
        var actions = [deleteAction]
        if let item = viewModel?.getItem(for: indexPath.row) {
            let completeAction = UIContextualAction(style: .normal, title: item.isCompleted ? "Mark Incomplete" : "Mark Complete") { [weak self, indexPath] _, _, completion in
                self?.viewModel?.handle(action: .toggleCompletion(row: indexPath.row))
                completion(true)
            }
            actions.append(completeAction)
        }
        return .init(actions: actions)
    }
}
