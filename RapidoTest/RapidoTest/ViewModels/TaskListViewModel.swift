//
//  TaskListViewModel.swift
//  RapidoTest
//
//  Created by Iron Man on 11/01/26.
//

import SwiftUI

protocol TaskListViewModeling: Observable {
    var dataSource: [Task] {get}
    func handle(action: TaskListActions)
}

@Observable
final class TaskListViewModel: TaskListViewModeling {
    var dataSource: [Task]
    private let repository: TaskRepositoryable
    
    init(repository: TaskRepositoryable) {
        self.repository = repository
        self.dataSource = []
    }
    
    func handle(action: TaskListActions) {
        switch action {
        case .viewLoaded:
            dataSource = repository.getAll()
        case let .addTask(title: title, description: description):
            guard let title else {
                return
            }
            let task = Task(id: UUID(), title: title, decription: description ?? "", isCompleted: false, dueDate: Date())
            
            repository.addTask(task: task)
            handle(action: .viewLoaded)
        case let .delete(item):
            repository.delete(id: item.id)
            handle(action: .viewLoaded)
        case var .toggleCompletion(item):
            item.isCompleted.toggle()
            repository.update(task: item)
            handle(action: .viewLoaded)
        }
    }
    
    private func getItem(for row: Int) -> Task? {
        guard row >= 0 && row < dataSource.count else { return nil }
        return dataSource[row]
    }
}

enum TaskListActions {
    case viewLoaded
    case addTask(title: String?, description: String?)
    case toggleCompletion(task: Task)
    case delete(task: Task)
}
