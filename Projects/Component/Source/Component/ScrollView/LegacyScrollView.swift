//
//  SwiftUIView.swift
//  Legacy-DesignSystem
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI

public struct LegacyScrollView<Content: View>: View {
    let title: String
    let icon: LegacyIconography
    let item: LegacyTabItem
    let content: Content
    
    public init(title: String,
                icon: LegacyIconography,
                item: LegacyTabItem,
                @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.item = item
        self.content = content()
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                Color.clear
                    .frame(height: 0)
                    .id("ScrollToTop-\(item.rawValue)")
                
                HStack {
                    Image(icon: icon)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .foreground(LegacyColor.Common.white)
                    Text(title)
                        .font(.bitFont(size: 28))
                        .foreground(LegacyColor.Common.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(12)
                
                content
                
                Spacer()
                    .frame(height: 110)
            }
        }
        .background(LegacyColor.Background.alternative)
    }
}
