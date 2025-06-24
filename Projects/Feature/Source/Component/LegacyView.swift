//
//  LegacyView.swift
//  Feature
//
//  Created by 김은찬 on 6/4/25.
//

import SwiftUI
import Component

struct LegacyView<Content: View>: View {
    @StateObject private var viewModel = ProfileViewModel()
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
                .padding(.top, 80)
                .overlay(alignment: .top) {
                    if let data = viewModel.userInfo {
                        LegacyTopBar(data: data)
                            .padding(.top, 10)
                    } else {
                        ErrorTopBar()
                    }
                }
        }
        .onAppear {
            Task {
                await viewModel.fetchMyinfo()
            }
        }
        .background(LegacyColor.Background.alternative)
    }
}
