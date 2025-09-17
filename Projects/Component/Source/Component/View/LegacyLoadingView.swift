//
//  LegacyLoadingView.swift
//  Component
//
//  Created by 김은찬 on 6/13/25.
//

import SwiftUI

public struct LegacyLoadingView: View {
    @State private var animate = false
    let description: String
    
    public init(animate: Bool = false, _ description: String) {
        self.animate = animate
        self.description = description
    }
    
    public var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 10) {
                    ForEach(0..<3) { index in
                        Circle()
                            .foreground(LegacyColor.Primary.normal)
                            .frame(width: 12, height: 12)
                            .offset(y: animate ? -6 : 6)
                            .animation(
                                Animation.easeInOut(duration: 0.3)
                                    .repeatForever()
                                    .delay(Double(index) * 0.1),
                                value: animate
                            )
                    }
                }
                .padding(.bottom, 30)
                
                Text(description)
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
            }
        }
        .onAppear {
            animate = true
        }
    }
}
