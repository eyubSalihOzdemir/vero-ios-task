//
//  DrawerView.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 22.11.2023.
//

import SwiftUI
import CodeScanner

// MARK: - Drawer View
struct DrawerView: View {
    @ObservedObject var contentViewViewModel: ContentViewViewModel
    
    // you can change this to simulate the result of the QR code scanner
    @State private var qrCodeSimulatedResult = "lagerar"
    
    init(contentViewViewModel: ContentViewViewModel) {
        self.contentViewViewModel = contentViewViewModel
    }
    
    var body: some View {
        Drawer(isOpened: $contentViewViewModel.isShowingDrawer) {
            // content of the drawer
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
                    CodeScannerView(codeTypes: [.qr], simulatedData: qrCodeSimulatedResult, completion: contentViewViewModel.handleScan)
                }
            }
            .frame(width: 250)
            .background(Rectangle()
                .shadow(radius: 8))
            
        } content: {
            // content of what's behind the drawer
            ListingView(contentViewViewModel: contentViewViewModel)
        }
    }
}
