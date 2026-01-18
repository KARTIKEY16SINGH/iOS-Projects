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

//final class TaskListViewModel {
//    
//    private let context = CoreDataStack.shared.context
//    
//    /// Tasks scheduled for review today
//    func fetchTasksForToday() -> [RevisionTask] {
//        let (start, end) = Date.todayRange()
//        
//        let request: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
//        request.predicate = NSPredicate(
//            format: "lastScheduledAt >= %@ AND lastScheduledAt < %@ AND isPaused == NO",
//            start as NSDate,
//            end as NSDate
//        )
//        
//        request.sortDescriptors = [
//            NSSortDescriptor(key: "lastScheduledAt", ascending: true)
//        ]
//        
//        return (try? context.fetch(request)) ?? []
//    }
//    
//    /// All tasks (fallback / other tabs)
//    func fetchAllTasks() -> [RevisionTask] {
//        let request: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
//        return (try? context.fetch(request)) ?? []
//    }
//}

final class TaskListViewModel {
    
    private let context = CoreDataStack.shared.context
    
    /// Call on app launch / viewDidLoad.
    /// Advances and reschedules tasks whose review time has passed.
    func advanceAndRescheduleMissedTasks() {
        let now = Date()
        
        let request: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
        request.predicate = NSPredicate(
            format: """
            isPaused == NO AND
            lastScheduledAt != nil AND
            lastScheduledAt < %@ 
            """,
            now as NSDate
        )
        
        guard let tasks = try? context.fetch(request) else { return }
        
        for task in tasks {
            // 1️⃣ Advance step (your rule)
            task.currentStep =
            SpacedRevisionScheduler.advance(step: task.currentStep)
            
            // 2️⃣ Schedule next revision
            NotificationManager.shared.scheduleNext(task: task)
        }
        
        // 3️⃣ Persist changes once
        CoreDataStack.shared.save()
    }
    
    func fetchAllTasks() -> [RevisionTask] {
        let request: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: true)
        ]
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchTodayTasks() -> [RevisionTask] {
        let (start, end) = Date.todayFrom8AMRange()
        return fetchTasks(from: start, to: end)
    }
    
    func fetchTasks(for date: Date) -> [RevisionTask] {
        let (start, end) = Date.revisionWindow(for: date)
        return fetchTasks(from: start, to: end)
    }
    
    private func fetchTasks(from start: Date, to end: Date) -> [RevisionTask] {
        let historyReq: NSFetchRequest<RevisionHistory> =
        RevisionHistory.fetchRequest()
        
        historyReq.predicate = NSPredicate(
            format: "scheduledAt >= %@ AND scheduledAt < %@",
            start as NSDate, end as NSDate
        )
        
        let history = (try? context.fetch(historyReq)) ?? []
        let ids = history.map { $0.taskId }
        
        guard !ids.isEmpty else { return [] }
        
        let taskReq: NSFetchRequest<RevisionTask> =
        RevisionTask.fetchRequest()
        
        taskReq.predicate = NSPredicate(format: "id IN %@", ids)
        
        return (try? context.fetch(taskReq)) ?? []
    }
    
    func backfillAllMissingHistoryOnce() {
        let context = CoreDataStack.shared.context
        
        // 1️⃣ Fetch all tasks that have a scheduled date
        let taskReq: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
        taskReq.predicate = NSPredicate(format: "lastScheduledAt != nil")
        
        guard let tasks = try? context.fetch(taskReq) else {
            print("❌ Failed to fetch tasks")
            return
        }
        
        var insertedCount = 0
        
        for task in tasks {
            guard
                let taskId = task.id,
                let scheduledAt = task.lastScheduledAt
            else { continue }
            
            // 2️⃣ Check if history already exists
            let historyReq: NSFetchRequest<RevisionHistory> =
            RevisionHistory.fetchRequest()
            
            historyReq.predicate = NSPredicate(
                format: "taskId == %@ AND scheduledAt == %@",
                taskId as CVarArg,
                scheduledAt as NSDate
            )
            
            let exists = (try? context.fetch(historyReq))?.isEmpty == false
            
            if !exists {
                // 3️⃣ Insert missing history entry
                let h = RevisionHistory(context: context)
                h.id = UUID()
                h.taskId = taskId
                h.scheduledAt = scheduledAt
                
                insertedCount += 1
                print("✅ Backfilled:", task.title ?? "(Untitled)", scheduledAt)
            }
        }
        
        // 4️⃣ Save once
        try? context.save()
        print("🎉 History backfill complete. Inserted:", insertedCount)
    }

}

extension RevisionTask {
    func readableDescription() {
        print()
        print(self.id, terminator: "\t")
        print(self.title, terminator: "\t")
        print(self.createdAt, terminator: "\t")
        print(self.isActive, terminator: "\t")
        print(self.currentStep, terminator: "\t")
        print(self.isPaused, terminator: "\t")
        print(self.lastScheduledAt, terminator: "\t")
        print()
        print()
    }
}
