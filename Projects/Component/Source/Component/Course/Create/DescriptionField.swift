//
//  DescriptionField.swift
//  Component
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI

public struct DescriptionField: View {
    @Binding var descriptionText: String
    @FocusState.Binding var isTextEditorFocused: Bool
    
    public init(
        descriptionText: Binding<String>,
        isTextEditorFocused: FocusState<Bool>.Binding
    ) {
        self._descriptionText = descriptionText
        self._isTextEditorFocused = isTextEditorFocused
    }
    
    public var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                if #available(iOS 16.0, *) {
                    TextEditor(text: $descriptionText)
                        .font(.body2(.medium))
                        .tint(LegacyColor.Common.white)
                        .scrollContentBackground(.hidden)
                        .scrollIndicators(.hidden)
                        .frame(height: 100)
                        .focused(_isTextEditorFocused)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .textInputAutocapitalization(.never)
                } else {
                    TextEditor(text: $descriptionText)
                        .font(.body2(.medium))
                        .tint(LegacyColor.Common.white)
                        .frame(height: 100)
                        .focused(_isTextEditorFocused)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .textInputAutocapitalization(.never)
                }
                
                if descriptionText.isEmpty {
                    Text("코스 설명을 입력해주세요.")
                        .font(.body2(.medium))
                        .foreground(LegacyColor.Label.alternative)
                        .padding(.top, 8)
                        .padding(.leading, 6)
                        .allowsHitTesting(false)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 16)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
}
