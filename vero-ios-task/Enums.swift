//
//  Enums.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 22.11.2023.
//

import Foundation

// error types to make debugging easier for us
enum DataError: Error {
    case invalidDataAuth
    case invalidResponseAuth
    case typeConversionAuth
    case invalidData
    case invalidResponse
    case typeConversion
    case message(_ error: Error?)
}

enum SortType: String, CaseIterable, Identifiable {
    var id: Self { self }
    case title = "Title"
    case task = "Task"
    case description = "Description"
}
