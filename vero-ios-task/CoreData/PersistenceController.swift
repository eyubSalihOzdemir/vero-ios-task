//
//  PersistenceController.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 19.11.2023.
//

import Foundation
import CoreData

struct PersistenceController {
    // a singleton for our entire app to use
    static let shared = PersistenceController()

    // storage for Core Data
    let container: NSPersistentContainer

    // an initializer to load Core Data, optionally able to use an in-memory store.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TaskDataModel")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
                
                print("Data saved to CoreData successfully.")
            } catch {
                NSLog("Unresolved error saving context: \(error)")
            }
        }
    }
}
