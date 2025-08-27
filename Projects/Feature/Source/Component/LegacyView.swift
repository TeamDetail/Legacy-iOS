//
//  LegacyView.swift
//  Feature
//
//  Created by 김은찬 on 6/4/25.
//

import SwiftUI
import Component

struct LegacyView<Content: View>: View {
    @State private var showMenu = false
    @EnvironmentObject private var viewModel: UserViewModel
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
                        LegacyTopBar(
                            showMenu: $showMenu,
                            data: data
                        )
                        .padding(.bottom, 10)
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
        .onTapGesture {
            withAnimation(.appSpring) {
                showMenu = false
            }
        }
        .background(LegacyColor.Background.alternative)
    }
}
