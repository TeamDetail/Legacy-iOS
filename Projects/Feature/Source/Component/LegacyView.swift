//
//  LegacyView.swift
//  Feature
//
//  Created by 김은찬 on 6/4/25.
//

import SwiftUI
import Component

struct LegacyView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
                .padding(.top, 80)
                .overlay(alignment: .top) {
                    LegacyTopBar()
                        .padding(.top, 10)
                }
        }
        .background(LegacyColor.Background.alternative)
    }
}
