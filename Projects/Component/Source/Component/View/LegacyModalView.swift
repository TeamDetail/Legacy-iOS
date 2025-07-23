//
//  LegacyBackgroundView.swift
//  Component
//
//  Created by 김은찬 on 7/18/25.
//

import SwiftUI

public struct LegacyModalView<Content: View>: View {
    let content: Content
    let dismiss: (() -> Void)?
    
    public init(
        _ dismiss: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.dismiss = dismiss
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss?()
                }
            
            content
                .frame(width: 370, height: 640)
                .clipShape(size: 20)
                .padding(5)
        }
    }
}

