//
//  TaskModifier.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import Foundation

protocol TaskModifiable {
    func convertFromStore(task: CDTask) -> Task
    func mapToStore(storeTask: CDTask, task: Task)
}

struct TaskModifier: TaskModifiable {
    func convertFromStore(task: CDTask) -> Task {
        debugPrint("convertFromStore task - \(task)")
        return .init(
            id: task.id ?? UUID(),
            title: task.title ?? "",
            decription: task.taskDescription ?? "",
            isCompleted: task.isCompleted,
            dueDate: task.dueDate ?? Date()
        )
    }
    
    func mapToStore(storeTask: CDTask, task: Task) {
        debugPrint("mapToStore storeTask - \(storeTask) task - \(task)")
        storeTask.id = task.id
        storeTask.title = task.title
        storeTask.taskDescription = task.decription
        storeTask.isCompleted = task.isCompleted
        storeTask.dueDate = task.dueDate
    }
}
