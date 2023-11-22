//
//  ContentView.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 17.11.2023.
//

import SwiftUI
import CoreData
import RefreshableScrollView
import CodeScanner

struct ContentView: View {
    @StateObject var contentViewViewModel = ContentViewViewModel()
    
    var body: some View {
        ZStack {
            DrawerView(contentViewViewModel: contentViewViewModel)

            LoadingIndicator(contentViewViewModel: contentViewViewModel)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

// MARK: - ListingView
struct ListingView: View {
    @ObservedObject var contentViewViewModel: ContentViewViewModel
    
    init(contentViewViewModel: ContentViewViewModel) {
        self.contentViewViewModel = contentViewViewModel
    }
    
    var body: some View {
        NavigationView {
            FilteredResults(filter: contentViewViewModel.debouncedSearchText, contentViewViewModel: contentViewViewModel)
        }
        .searchable(text: $contentViewViewModel.searchText, prompt: "Search for tasks")
        .onChange(of: contentViewViewModel.searchText) { oldValue, newValue in
            if !newValue.isEmpty {
                let workItem = DispatchWorkItem {
                    contentViewViewModel.debouncedSearchText = contentViewViewModel.searchText
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: workItem)
            } else {
                contentViewViewModel.debouncedSearchText = ""
            }
            
        }
        .navigationTitle("Tasks")
    }
}
