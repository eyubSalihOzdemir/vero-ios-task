//
//  Task.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 18.11.2023.
//

import Foundation

struct Task: Codable {
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
}
