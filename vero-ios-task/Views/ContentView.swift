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
    @State private var debouncedSearchText = ""
    
    var body: some View {
        ZStack {
            Drawer(isOpened: $contentViewViewModel.isShowingDrawer) {
                ZStack {
                    Color.white
                    
                    NavigationView {
                        VStack {
                            Text("test")
                            Picker("Auto-Join Hotspot", selection: $contentViewViewModel.selectedSortType) {
                                ForEach(SortType.allCases, id: \.self) { sortType in
                                    Text(String(describing: sortType.rawValue))
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                        .navigationTitle("Settings")
                    }
                }
                .frame(width: 250)
                .shadow(radius: 8)
            } content: {
                NavigationView {
                    FilteredResults(filter: debouncedSearchText, contentViewViewModel: contentViewViewModel)
                }
                .searchable(text: $searchText, prompt: "Search for tasks")
                .onChange(of: searchText) { oldValue, newValue in
                    let workItem = DispatchWorkItem {
                        debouncedSearchText = searchText
                    }
                    DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500), execute: workItem)
                }
                .navigationTitle("Tasks")
            }

            // loading indicator
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
