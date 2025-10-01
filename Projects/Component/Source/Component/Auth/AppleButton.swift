//
//  AppleButton.swift
//  Component
//
//  Created by 김은찬 on 9/30/25.
//

import SwiftUI

public struct AppleButton: View {
    let action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .foreground(LegacyColor.Background.normal)
                .frame(width: 300, height: 45)
                .overlay {
                    HStack {
                        Image(icon: .appleLogo)
                        Spacer()
                        Text("Apple 로그인")
                            .font(.body2(.bold))
                            .foreground(LegacyColor.Common.white)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(width: 300)
                }
        }
    }
}
