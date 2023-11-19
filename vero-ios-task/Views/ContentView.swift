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
    
    init() { }
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Group {
                        if tasks.count == 0 {
                            Text("No tasks here—quiet as a library.")
                        } else {
                            List(tasks) { task in
                                Text(task.title ?? "No title")
                            }
                            .allowsHitTesting(!contentViewViewModel.loading)
                            .refreshable {
                                //contentViewViewModel.fetch()
                                withAnimation {
                                    contentViewViewModel.loading = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        contentViewViewModel.loading = false
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Tasks")
                .toolbar {
                    Button {
                        //contentViewViewModel.fetch()
                        withAnimation {
                            contentViewViewModel.loading = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                contentViewViewModel.loading = false
                            }
                        }
                    } label: {
                        Text(tasks.count > 1 ? "Refresh" : "Get tasks")
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
}

#Preview {
    ContentView()
}
