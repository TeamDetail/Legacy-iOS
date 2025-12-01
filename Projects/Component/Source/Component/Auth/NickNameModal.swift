//
//  NickNameModal.swift
//  Component
//
//  Created by 김은찬 on 12/1/25.
//

import SwiftUI

public struct NickNameModal: View {
    @Binding var nickName: String
    @FocusState.Binding var isTextFieldFocused: Bool
    let action: () -> Void
    
    public init(
        nickName: Binding<String>,
        isTextFieldFocused: FocusState<Bool>.Binding,
        action: @escaping () -> Void
    ) {
        self._nickName = nickName
        self._isTextFieldFocused = isTextFieldFocused
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            Text("이름을 알려주세요!")
                .font(.heading1(.bold))
                .foreground(LegacyColor.Common.white)
            
            HStack(spacing: 4) {
                ZStack(alignment: .leading) {
                    if nickName.isEmpty {
                        Text("당신의 이름은?")
                            .font(.label(.medium))
                            .foreground(LegacyColor.Label.alternative)
                            .padding(.leading, 2)
                    }
                    
                    TextField("", text: $nickName)
                        .font(.label(.medium))
                        .tint(LegacyColor.Common.white)
                        .submitLabel(.done)
                        .focused(_isTextFieldFocused)
                }
            }
            .frame(width: 200, height: 40)
            .padding(.horizontal, 14)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 12)
            
            
            AnimationButton {
                action()
            } label: {
                Text("레거시 시작하기")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Purple.normal)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Purple.normal)
                    )
            }
            .disabled(nickName.isEmpty)
            .padding(.horizontal, 14)
        }
        .frame(width: 260, height: 178)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
    }
}
