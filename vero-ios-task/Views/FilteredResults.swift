//
//  FilteredResults.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 21.11.2023.
//

import SwiftUI
import RefreshableScrollView

struct FilteredResults: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var contentViewViewModel: ContentViewViewModel
    
    @FetchRequest var tasks: FetchedResults<Task>
    
    @State private var showingAlert = false
    
    init(filter: String, contentViewViewModel: ContentViewViewModel) {
        // we're going to add filter to every field and combine them with OR logic so that the search bar filter works on every field
        
        let predicateArray = [
            NSPredicate(format: "task CONTAINS %@", filter),
            NSPredicate(format: "title CONTAINS %@", filter),
            NSPredicate(format: "taskDescription CONTAINS %@", filter),
            NSPredicate(format: "sort CONTAINS %@", filter),
            NSPredicate(format: "wageType CONTAINS %@", filter),
            NSPredicate(format: "businessUnitKey CONTAINS %@", filter),
            NSPredicate(format: "businessUnit CONTAINS %@", filter),
            NSPredicate(format: "parentTaskID CONTAINS %@", filter),
            NSPredicate(format: "preplanningBoardQuickSelect CONTAINS %@", filter),
            NSPredicate(format: "colorCode CONTAINS %@", filter),
            NSPredicate(format: "workingTime CONTAINS %@", filter),
            NSPredicate(format: "isAvailableInTimeTrackingKioskMode CONTAINS %@", filter)
        ]
        
        if filter.isEmpty {
            _tasks = FetchRequest<Task>(sortDescriptors: [])
        } else {
            _tasks = FetchRequest<Task>(
                sortDescriptors: [],
                predicate: NSCompoundPredicate(orPredicateWithSubpredicates: predicateArray)
            )
        }
        
        self.contentViewViewModel = contentViewViewModel
    }
    
    var body: some View {
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
    FilteredResults(filter: "G", contentViewViewModel: ContentViewViewModel())
}
