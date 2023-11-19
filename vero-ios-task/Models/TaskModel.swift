//
//  Task.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 18.11.2023.
//

import Foundation

struct TaskModel: Codable {
    let task: String?
    let title: String?
    let taskDescription: String?
    let sort: String?
    let wageType: String?
    let businessUnitKey: String?
    let businessUnit: String?
    let parentTaskID: String?
    let preplanningBoardQuickSelect: String?
    let colorCode: String?
    let workingTime: String?
    let isAvailableInTimeTrackingKioskMode: Bool?
    
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
