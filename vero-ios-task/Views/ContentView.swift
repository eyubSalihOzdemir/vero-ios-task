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
