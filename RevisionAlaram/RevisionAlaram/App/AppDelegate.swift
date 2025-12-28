//
//  AppDelegate.swift
//  RevisionAlarm
//
//  Created by Iron Man on 27/12/25.
//

import UIKit
import CoreData

let coreDataModelName = "RevisionAlaram"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) {_,_ in }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("Recieved Notification")
        guard
            let idString = response.notification.request.content
                .userInfo["taskId"] as? String,
            let uuid = UUID(uuidString: idString)
        else {
            completionHandler()
            return
        }
        
        let req: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        
        if let task = try? CoreDataStack.shared.context.fetch(req).first {
            task.currentStep =
            SpacedRevisionScheduler.advance(step: task.currentStep)
            NotificationManager.shared.scheduleNext(task: task)
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("Foreground delivery")
        
        if let idString =
            notification.request.content.userInfo["taskId"] as? String,
           let uuid = UUID(uuidString: idString) {
            
            let req: NSFetchRequest<RevisionTask> = RevisionTask.fetchRequest()
            req.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
            
            if let task = try? CoreDataStack.shared.context.fetch(req).first {
                task.currentStep =
                SpacedRevisionScheduler.advance(step: task.currentStep)
                NotificationManager.shared.scheduleNext(task: task)
            }
        }
        
        completionHandler([.banner, .sound])
    }

}

