//
//  ContentView.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 17.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewViewModel = ContentViewViewModel()
    
    var body: some View {
        VStack {
            Button {
                contentViewViewModel.fetch()
            } label: {
                Text("Get Resources")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
