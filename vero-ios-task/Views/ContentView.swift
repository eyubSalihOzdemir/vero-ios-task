//
//  ContentView.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 17.11.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @StateObject var contentViewViewModel = ContentViewViewModel()
    
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    init() {
    }
    
    var body: some View {
        VStack {
            List(tasks) { task in
                Text(task.title ?? "No title")
            }
            
            Button {
                contentViewViewModel.fetch()
            } label: {
                Text("Get Resources")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
