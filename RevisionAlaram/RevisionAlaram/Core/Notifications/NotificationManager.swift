//
//  NotificationManager.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//

import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    func scheduleNext(task: RevisionTask) {
        guard
            task.isPaused == false,
            let id = task.id,
            let title = task.title
        else { return }
        
        let step = task.currentStep
        let nextDate = SpacedRevisionScheduler.nextRevisionDate(
            from: Date(),
            step: step
        )
        
        let content = UNMutableNotificationContent()
        content.title = "Revision Reminder"
        content.body = "Revise: \(title)"
        content.subtitle = "Revision Count: \(task.currentStep)"
        content.userInfo = ["taskId": id.uuidString]
        content.sound = .defaultCritical
        
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
        task.currentStep = step + 1
        CoreDataStack.shared.save()
    }
    
    func cancel(task: RevisionTask) {
        guard let id = task.id else { return }
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: [id.uuidString]
            )
    }
}
