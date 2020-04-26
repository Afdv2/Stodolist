//
//  List+CoreDataProperties.swift
//  
//
//  Created by Alexandr on 23.04.2020.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var guid: String
    @NSManaged public var summary: String
    @NSManaged public var title: String
    @NSManaged public var tasks: [Task]
}

// MARK: Generated accessors for tasks
extension List {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: [Task])

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: [Task])

}
