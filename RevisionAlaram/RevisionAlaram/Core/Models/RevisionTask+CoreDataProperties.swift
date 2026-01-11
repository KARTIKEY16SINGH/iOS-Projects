//
//  RevisionTask+CoreDataProperties.swift
//  RevisionAlaram
//
//  Created by Iron Man on 27/12/25.
//
//

public import Foundation
public import CoreData


public typealias RevisionTaskCoreDataPropertiesSet = NSSet

extension RevisionTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RevisionTask> {
        return NSFetchRequest<RevisionTask>(entityName: "RevisionTask")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var isActive: Bool
    @NSManaged public var currentStep: Int16
    @NSManaged public var isPaused: Bool
    @NSManaged public var lastScheduledAt: Date?

}

extension RevisionTask : Identifiable {

}

