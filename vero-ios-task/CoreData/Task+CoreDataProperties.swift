//
//  Task+CoreDataProperties.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 19.11.2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var businessUnit: String?
    @NSManaged public var businessUnitKey: String?
    @NSManaged public var colorCode: String?
    @NSManaged public var isAvailableInTimeTrackingKioskMode: Bool
    @NSManaged public var parentTaskID: String?
    @NSManaged public var preplanningBoardQuickSelect: String?
    @NSManaged public var sort: String?
    @NSManaged public var task: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var wageType: String?
    @NSManaged public var workingTime: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case task = "task"
        case taskDescription = "description"
        case sort = "sort"
        case wageType = "wageType"
        case businessUnitKey = "businessUnitKey"
        case businessUnit = "businessUnit"
        case parentTaskID = "parentTaskID"
        case preplanningBoardQuickSelect = "preplanningBoardQuickSelect"
        case colorCode = "colorCode"
        case workingTime = "workingTime"
        case isAvailableInTimeTrackingKioskMode = "isAvailableInTimeTrackingKioskMode"
    }
    
    var wrappedTitle: String { title ?? "No title" }
    var wrappedTask: String { task ?? "No task" }
    var wrappedTaskDescription: String { taskDescription ?? "No description" }
    var wrappedSort: String { sort ?? "No sort" }
    var wrappedWageType: String { wageType ?? "No wage type" }
    var wrappedBusinessUnitKey: String { businessUnitKey ?? "No business unit key" }
    var wrappedBusinessUnit: String { businessUnit ?? "No business unit" }
    var wrappedParentTaskID: String { parentTaskID ?? "No parent task ID" }
    var wrappedPreplanningBoardQuickSelect: String { preplanningBoardQuickSelect ?? "No preplanning board quick select" }
    var wrappedColorCode: String { colorCode ?? "#ffffff" }
    var wrappedWorkingTime: String { workingTime ?? "No working time" }
    var wrappedIsAvailableTimeTrackingKioskMode: Bool { isAvailableInTimeTrackingKioskMode }
    
}

extension Task : Identifiable {
    
}
