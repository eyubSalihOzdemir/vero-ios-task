//
//  ContentView.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 17.11.2023.
//

import SwiftUI
import CoreData
import RefreshableScrollView

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @StateObject var contentViewViewModel = ContentViewViewModel()
    
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    @State private var showingAlert = false
    @State private var searchText = ""
    
    init() {
        
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if tasks.count == 0 {
                        Text("No tasks here—quiet as a library.")
                    } else {
                        RefreshableScrollView {
                            ForEach(tasks) { task in
                                LazyVStack(alignment: .leading) {
                                    ZStack {
                                        Color.white
                                    
                                        HStack {
                                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                .frame(width: 50, height: 50)
                                                .foregroundStyle(Color.init(hex: task.colorCode ?? "#000000").opacity(0.2))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                        .stroke(Color.init(hex: task.colorCode ?? "#000000").opacity(0.5), lineWidth: 2)
                                                }
                                                .overlay {
                                                    Image(systemName: "pin.fill")
                                                        .foregroundStyle(Color.init(hex: task.colorCode ?? "#000000"))
                                                }
                                            
                                            VStack(alignment: .leading) {
                                                Text(task.title ?? "No title")
                                                    .font(.title2.weight(.semibold))
                                                
                                                Text("Task: \(task.task ?? "No task")")
                                                    .font(.callout.weight(.regular))
                                                
                                                Text(task.taskDescription ?? "No description")
                                                    .font(.callout.weight(.light))
                                                    .padding(.top, 2)
                                            }
                                            Spacer()
                                        }
                                        .padding(10)
                                    }
                                    .fixedSize(horizontal: false, vertical: true)
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                                    .shadow(color: Color.black.opacity(0.2), radius: 2)
                                }
                            }
                            .onDelete(perform: removeTask)
                        }
                        .refreshable {
                            removeAllTasks()
                            contentViewViewModel.fetch()
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
                    
                    if tasks.count > 0 {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showingAlert.toggle()
                            } label: {
                                Text("Clear")
                            }
                            .alert("Delete Everything", isPresented: $showingAlert) {
                                Button("Cancel", role: .cancel) {
                                    // do nothing
                                }
                                Button("Yes") {
                                    removeAllTasks()
                                }
                            } message: {
                                Text("Are you sure you want to delete all tasks?")
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for tasks")
            
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
