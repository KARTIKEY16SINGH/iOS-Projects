//
//  TaskListViewModel.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//

import Foundation
import CoreData

//final class TaskListViewModel {
//    
//    private let context = CoreDataStack.shared.context
//    
//    func fetchTasks() -> [RevisionTask] {
//        let request: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
//        return (try? context.fetch(request)) ?? []
//    }
//    
//    func delete(task: RevisionTask) {
//        guard let id = task.id else { return }
//        NotificationManager.shared.cancel(taskId: id)
//        context.delete(task)
//        CoreDataStack.shared.saveIfNeeded()
//    }
//}
