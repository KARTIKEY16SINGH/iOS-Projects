//
//  NotificationManager.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//

import UserNotifications
internal import CoreData

final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    func scheduleNext(task: RevisionTask) {
        guard
            task.isPaused == false,
            let id = task.id,
            let title = task.title
        else { return }
        
        let baseDate = task.lastScheduledAt ?? (task.createdAt ?? Date())
        
        let step = task.currentStep
        let nextDate = SpacedRevisionScheduler.nextRevisionDate(
            from: baseDate,
            step: step
        )
        
        let content = UNMutableNotificationContent()
        content.title = "Revision Reminder"
        content.body = "Revise: \(title)"
        content.subtitle = "Revision Count: \(task.currentStep)"
        content.userInfo = ["taskId": id.uuidString]
        content.sound = .defaultRingtone
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute, .second],
                from: nextDate
            ),
            repeats: false
        )
        dump(trigger)
        UNUserNotificationCenter.current().add(
            UNNotificationRequest(
                identifier: id.uuidString,
                content: content,
                trigger: trigger
            )
        )
        
        task.lastScheduledAt = nextDate
        task.currentStep = step
        logHistory(taskId: id, date: nextDate)
        CoreDataStack.shared.save()
    }
    
    func cancel(task: RevisionTask) {
        guard let id = task.id else { return }
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: [id.uuidString]
            )
    }
    
    func scheduleInitial(task: RevisionTask, at date: Date) {
        guard
            task.isPaused == false,
            let id = task.id,
            let title = task.title
        else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Revision Reminder"
        content.body = "Revise: \(title)"
        content.userInfo = ["taskId": id.uuidString]
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: date
            ),
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
        
        task.lastScheduledAt = date
        logHistory(taskId: id, date: date)
        CoreDataStack.shared.save()
    }
    
    private func logHistory(taskId: UUID, date: Date) {
        let ctx = CoreDataStack.shared.context
        let h = RevisionHistory(context: ctx)
        
        h.id = UUID()
        h.taskId = taskId
        h.scheduledAt = date
        
        CoreDataStack.shared.save()
    }

}
