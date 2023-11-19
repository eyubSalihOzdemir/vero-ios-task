//
//  vero_ios_taskApp.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 17.11.2023.
//

import SwiftUI

@main
struct vero_ios_taskApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        // save the changes in the memory to CoreData when the app moves to the background
        .onChange(of: scenePhase) {
            persistenceController.save()
        }
    }
}
