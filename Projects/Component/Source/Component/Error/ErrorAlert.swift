//
//  ErrorAlert.swift
//  Component
//
//  Created by 김은찬 on 6/13/25.
//

import SwiftUI

public struct LegacyErrorAlert: View {
    @Binding var isPresented: Bool
    let description: String

    @State private var showIcon = false
    @State private var showText = false

    public init(isPresented: Binding<Bool>, description: String) {
        self._isPresented = isPresented
        self.description = description
    }

    public var body: some View {
        ZStack {
            if isPresented {
                HStack(spacing: 12) {
                    Image(icon: .wrong)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaleEffect(showIcon ? 1.0 : 0.5)
                        .opacity(showIcon ? 1.0 : 0)
                        .animation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.05), value: showIcon)

                    Text(description)
                        .font(.body1(.bold))
                        .foregroundColor(.white)
                        .opacity(showText ? 1.0 : 0)
                        .offset(x: showText ? 0 : -10)
                        .animation(.easeOut(duration: 0.3).delay(0.1), value: showText)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red.opacity(0.9), Color.red.opacity(0.6)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(size: 16)
                .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .transition(.move(edge: .leading).combined(with: .opacity))
                .onAppear {
                    showIcon = true
                    showText = true
                }
                .onDisappear {
                    showIcon = false
                    showText = false
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: isPresented)
    }
}
