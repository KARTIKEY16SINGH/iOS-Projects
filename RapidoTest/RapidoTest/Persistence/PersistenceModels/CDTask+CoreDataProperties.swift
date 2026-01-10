//
//  CDTask+CoreDataProperties.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//
//

public import Foundation
public import CoreData


public typealias CDTaskCoreDataPropertiesSet = NSSet

extension CDTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTask> {
        return NSFetchRequest<CDTask>(entityName: "CDTask")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var dueDate: Date?

}

extension CDTask : Identifiable {

}
