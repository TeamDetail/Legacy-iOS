//
//  GoogleButton.swift
//  Component
//
//  Created by 김은찬 on 9/30/25.
//

import SwiftUI

public struct GoogleButton: View {
    let action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .foreground(LegacyColor.Common.white)
                .frame(width: 300, height: 45)
                .overlay {
                    HStack {
                        Image(icon: .googleLogo)
                        Spacer()
                        Text("Google 로그인")
                            .font(.body2(.bold))
                            .foreground(LegacyColor.Common.black)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(width: 300)
                }
        }
    }
}
