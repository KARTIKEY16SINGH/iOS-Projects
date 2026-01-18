//
//  RevisionHistory+CoreDataProperties.swift
//  RevisionAlaram
//
//  Created by Iron Man on 19/01/26.
//
//

public import Foundation
public import CoreData


public typealias RevisionHistoryCoreDataPropertiesSet = NSSet

extension RevisionHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RevisionHistory> {
        return NSFetchRequest<RevisionHistory>(entityName: "RevisionHistory")
    }

    @NSManaged public var id: UUID
    @NSManaged public var taskId: UUID
    @NSManaged public var scheduledAt: Date

}

extension RevisionHistory : Identifiable {

}
