//
//  LoadingIndicator.swift
//  vero-ios-task
//
//  Created by Salih Özdemir on 22.11.2023.
//

import SwiftUI

struct LoadingIndicator: View {
    @ObservedObject var contentViewViewModel: ContentViewViewModel
    
    init(contentViewViewModel: ContentViewViewModel) {
        self.contentViewViewModel = contentViewViewModel
    }
    
    var body: some View {
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
}

