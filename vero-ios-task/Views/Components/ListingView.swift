//
//  ListView.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 22.11.2023.
//

import SwiftUI

struct ListingView: View {
    @ObservedObject var contentViewViewModel: ContentViewViewModel
    
    init(contentViewViewModel: ContentViewViewModel) {
        self.contentViewViewModel = contentViewViewModel
    }
    
    var body: some View {
        NavigationView {
            FilteredResults(filter: contentViewViewModel.debouncedSearchText, contentViewViewModel: contentViewViewModel)
        }
        .searchable(text: $contentViewViewModel.searchText, prompt: "Search for resources")
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
    }
}
