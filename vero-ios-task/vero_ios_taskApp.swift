//
//  vero_ios_taskApp.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 17.11.2023.
//

import SwiftUI

@main
struct vero_ios_taskApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
