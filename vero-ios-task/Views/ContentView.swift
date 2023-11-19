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
        ZStack {
            NavigationView {
                VStack {
                    if tasks.count == 0 {
                        Text("No tasks here—quiet as a library.")
                    } else {
                        List {
                            ForEach(tasks) { task in
                                HStack {
                                    Text(task.taskDescription ?? "No title")
                                    
                                    Spacer()
                                    
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 20, height: 20)
                                }
                            }
                            .onDelete(perform: removeTask)
                        }
                        .allowsHitTesting(!contentViewViewModel.loading)
                        .refreshable {
                            removeAllTasks()
                            contentViewViewModel.fetch()
                            /*withAnimation {
                                contentViewViewModel.loading = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    contentViewViewModel.loading = false
                                }
                            }*/
                        }
                    }
                }
                .navigationTitle("Tasks")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            removeAllTasks()
                            contentViewViewModel.fetch()
                        } label: {
                            Text(tasks.count > 0 ? "Refresh" : "Get tasks")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            removeAllTasks()
                        } label: {
                            Text("Clear")
                        }
                    }
                }
            }
            
            ZStack {
                Color.clear
                    .background(.black)
                    .opacity(0.5)
                
                ProgressView()
                    .frame(width: 100, height: 100)
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    .ignoresSafeArea(.all)
            }
            .opacity(contentViewViewModel.loading ? 1 : 0)
            .animation(.easeInOut, value: contentViewViewModel.loading)
        }
        .ignoresSafeArea()
    }
    
    func removeTask(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            moc.delete(task)
        }
        PersistenceController.shared.save()
    }
    
    func removeAllTasks() {
        contentViewViewModel.loading = true
        
        for task in tasks {
            moc.delete(task)
        }
        PersistenceController.shared.save()
        
        contentViewViewModel.loading = false
    }
}

#Preview {
    ContentView()
}
