//
//  TitleField.swift
//  Component
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI

public struct TitleField: View {
    @Binding var titleText: String
    @FocusState.Binding var isTextFieldFocused: Bool
    
    public init(
        titleText: Binding<String>,
        isTextFieldFocused: FocusState<Bool>.Binding
    ) {
        self._titleText = titleText
        self._isTextFieldFocused = isTextFieldFocused
    }
    
    public var body: some View {
        VStack {
            ZStack {
                TextField("", text: $titleText)
                    .font(.headline(.medium))
                    .tint(LegacyColor.Common.white)
                    .submitLabel(.done)
                    .frame(height: 56)
                    .focused(_isTextFieldFocused)
                
                HStack {
                    if titleText.isEmpty {
                        Text("코스 이름을 입력해주세요.")
                            .font(.headline(.medium))
                            .foreground(LegacyColor.Label.alternative)
                    }
                    Spacer()
                }
                .padding(.horizontal, 4)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 12)
        }
        .frame(maxWidth: .infinity, maxHeight: 56)
    }
}
