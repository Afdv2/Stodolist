//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Alexandr on 23.04.2020.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var guid: String
    @NSManaged public var status: Bool
    @NSManaged public var title: String
    @NSManaged public var list: List

}
