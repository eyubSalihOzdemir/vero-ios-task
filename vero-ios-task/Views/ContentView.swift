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
    @StateObject var contentViewViewModel = ContentViewViewModel()
    
    @State private var searchText = ""
    
    //@FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Task>
    
    init() {
        
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                FilteredResults(filter: searchText, contentViewViewModel: contentViewViewModel)
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
}

#Preview {
    ContentView()
}
