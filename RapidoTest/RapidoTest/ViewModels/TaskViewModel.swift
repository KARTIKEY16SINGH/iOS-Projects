//
//  TaskViewModel.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import Foundation

protocol TaskViewModelable {
    var view: TaskViewable? {get set}
    func handle(action: TaskActions)
    func getNumberOfItems() -> Int
    func getItem(for row: Int) -> Task?
}

enum TaskActions {
    case viewLoaded
    case addTask(title: String?, description: String?)
    case delete(index: Int)
    case toggleCompletion(row: Int)
}

final class TaskViewModel {
    weak var view: TaskViewable?
    private let repository: TaskRepositoryable
    private var dataSource: [Task]
    
    init(repository: TaskRepositoryable) {
        self.repository = repository
        dataSource = []
    }
}

extension TaskViewModel: TaskViewModelable {
    func handle(action: TaskActions) {
        switch action {
        case .viewLoaded:
            dataSource = repository.getAll()
            view?.dataUpdated()
        case let .addTask(title: title, description: description):
            guard let title else {
                return
            }
            let task = Task(id: UUID(), title: title, decription: description ?? "", isCompleted: false, dueDate: Date())
            
            repository.addTask(task: task)
            view?.addedTask()
            handle(action: .viewLoaded)
        case let .delete(index):
            guard let item = getItem(for: index) else { return }
            repository.delete(id: item.id)
            handle(action: .viewLoaded)
        case let .toggleCompletion(row):
            guard var item = getItem(for: row) else { return }
            item.isCompleted.toggle()
            repository.update(task: item)
            handle(action: .viewLoaded)
        }
    }
    
    func getAvailableTabs() -> [Tabs] {
        Tabs.allCases
    }
    
    func getNumberOfItems() -> Int {
        dataSource.count
    }
    
    func getItem(for row: Int) -> Task? {
        guard row >= 0 && row < dataSource.count else { return nil }
        return dataSource[row]
    }
}

enum Tabs: CaseIterable {
    case uiKit
}
