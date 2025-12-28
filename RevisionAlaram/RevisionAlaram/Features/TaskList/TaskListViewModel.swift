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
        
        let request: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
        request.predicate = NSPredicate(
            format: """
            lastScheduledAt >= %@ AND
            lastScheduledAt < %@ AND
            isPaused == NO
            """,
            start as NSDate,
            end as NSDate
        )
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "lastScheduledAt", ascending: true)
        ]
        
        return (try? context.fetch(request)) ?? []
    }
}


extension Date {
    static func todayRange() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        return (start, end)
    }
}

import Foundation

extension Date {
    
    /// Custom "Today" window:
    /// From today 08:00 → tomorrow 08:00 (local time)
    static func todayFrom8AMRange() -> (start: Date, end: Date) {
        let calendar = Calendar.current
        let now = Date()
        
        var startComponents = calendar.dateComponents(
            [.year, .month, .day],
            from: now
        )
        startComponents.hour = 8
        startComponents.minute = 0
        startComponents.second = 0
        
        let start = calendar.date(from: startComponents)!
        
        let end = calendar.date(
            byAdding: .day,
            value: 1,
            to: start
        )!
        
        // If current time is before 8 AM, shift window back one day
        if now < start {
            let adjustedStart = calendar.date(
                byAdding: .day,
                value: -1,
                to: start
            )!
            let adjustedEnd = start
            debugPrint("Date todayFrom8AMRange start -> \(adjustedStart) , end -> \(adjustedEnd) ")
            return (adjustedStart, adjustedEnd)
        }
        debugPrint("Date todayFrom8AMRange start -> \(start) , end -> \(end) ")
        return (start, end)
    }
}
