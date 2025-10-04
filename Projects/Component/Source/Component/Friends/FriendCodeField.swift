//
//  FriendCodeField.swift
//  Component
//
//  Created by 김은찬 on 10/4/25.
//

import SwiftUI

public struct FriendCodeField: View {
    @Binding var friendCode: String
    let action: () -> Void
    
    public init(
        _ friendCode: Binding<String>,
        action: @escaping () -> Void
    ) {
        self._friendCode = friendCode
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            VStack {
                ZStack {
                    TextField("", text: $friendCode)
                        .font(.headline(.medium))
                        .tint(LegacyColor.Common.white)
                        .submitLabel(.done)
                        .frame(height: 50)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .textInputAutocapitalization(.never)
                    
                    HStack {
                        if friendCode.isEmpty {
                            Text("추가하고 싶은 친구의 코드 입력...")
                                .font(.body1(.medium))
                                .foreground(LegacyColor.Label.alternative)
                                .allowsHitTesting(false)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 4)
                }
                .padding(.horizontal, 12)
                .background(LegacyColor.Fill.normal)
                .clipShape(size: 16)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .padding(.horizontal, 8)
            
            AnimationButton {
                action()
            } label: {
                Circle()
                    .frame(width: 36, height: 36)
                    .foreground(LegacyColor.Fill.netural)
                    .overlay {
                        Image(icon: .airPlane)
                            .font(.headline(.bold))
                            .foreground(LegacyColor.Label.netural)
                    }
            }
        }
    }
}
