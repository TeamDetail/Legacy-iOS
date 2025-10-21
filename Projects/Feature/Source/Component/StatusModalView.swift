//
//  StatusModalView.swift
//  Feature
//
//  Created by 김은찬 on 9/14/25.
//

import SwiftUI
import Component

struct StatusModalView: View {
    let message: String
    let statusType: LegacyStatusType
    let onClear: () -> Void
    let bottomPadding: CGFloat
    
    @State private var isVisible = false
    
    var body: some View {
        Group {
            if !message.isEmpty {
                LegacyStatusModal(
                    statusType: statusType,
                    description: message
                )
                .padding(.bottom, bottomPadding)
                .scaleEffect(isVisible ? 1.0 : 0.8)
                .opacity(isVisible ? 1.0 : 0.0)
                .offset(y: isVisible ? 0 : 20)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isVisible)
                .onAppear {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        isVisible = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeOut(duration: 0.3)) {
                            isVisible = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            onClear()
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func statusModal(
        message: String,
        statusType: LegacyStatusType,
        bottomPadding: CGFloat = 75,
        onClear: @escaping () -> Void
    ) -> some View {
        self.overlay(alignment: .bottom) {
            VStack {
                Spacer()
                StatusModalView(
                    message: message,
                    statusType: statusType,
                    onClear: onClear,
                    bottomPadding: bottomPadding
                )
            }
            .allowsHitTesting(false)
        }
    }
}
