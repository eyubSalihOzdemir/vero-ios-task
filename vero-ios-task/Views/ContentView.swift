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
            Drawer(isOpened: $contentViewViewModel.isShowingDrawer) {
                ZStack {
                    Color.white
                    
                    NavigationView {
                        VStack {
                            HStack {
                                Text("Sort type")
                                Spacer()
                                Picker("Sort type", selection: $contentViewViewModel.selectedSortType) {
                                    ForEach(SortType.allCases) { sortType in
                                        Text(String(describing: sortType.rawValue))
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                            
                            HStack {
                                Text("Scan QR code")
                                Spacer()
                                Button {
                                    contentViewViewModel.isShowingQRScanner.toggle()
                                } label: {
                                    Image(systemName: "qrcode.viewfinder")
                                }
                                .padding(.trailing, 10)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                        .navigationTitle("Settings")
                    }
                    .sheet(isPresented: $contentViewViewModel.isShowingQRScanner) {
                        CodeScannerView(codeTypes: [.qr], simulatedData: "lagerar", completion: contentViewViewModel.handleScan)
                    }
                }
                .frame(width: 250)
                .background(Rectangle()
                  .shadow(radius: 8))
                
            } content: {
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
