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
        case businessUnit = "businessUnit"
        case businessUnitKey = "businessUnitKey"
        case colorCode = "colorCode"
        case isAvailableInTimeTrackingKioskMode = "isAvailableInTimeTrackingKioskMode"
        case parentTaskID = "parentTaskID"
        case preplanningBoardQuickSelect = "preplanningBoardQuickSelect"
        case sort = "sort"
        case task = "task"
        case taskDescription = "description"
        case title = "title"
        case wageType = "wageType"
        case workingTime = "workingTime"
    }
}

extension Task : Identifiable {
    
}
