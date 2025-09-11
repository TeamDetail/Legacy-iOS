//
//  CommentField.swift
//  Component
//
//  Created by 김은찬 on 8/21/25.
//

import SwiftUI

public struct CommentField: View {
    @Binding var commentText: String
    @Binding var isKeyboardFocused: Bool
    @FocusState private var isTextEditorFocused: Bool
    
    public init(commentText: Binding<String>, isKeyboardFocused: Binding<Bool>) {
        self._commentText = commentText
        self._isKeyboardFocused = isKeyboardFocused
    }
    
    private func dismissKeyboard() {
        isTextEditorFocused = false
        isKeyboardFocused = false
    }
    
    public var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                if #available(iOS 16.0, *) {
                    TextEditor(text: $commentText)
                        .font(.body2(.medium))
                        .tint(LegacyColor.Common.white)
                        .scrollContentBackground(.hidden)
                        .scrollIndicators(.hidden)
                        .frame(height: 130)
                        .focused($isTextEditorFocused)
                        .onTapGesture {
                            isTextEditorFocused = true
                        }
                } else {
                    TextEditor(text: $commentText)
                        .font(.body2(.medium))
                        .tint(LegacyColor.Common.white)
                        .frame(height: 130)
                        .focused($isTextEditorFocused)
                        .onTapGesture {
                            isTextEditorFocused = true
                        }
                }
                
                if commentText.isEmpty {
                    Text("유적지에 대한 감상을 입력해주세요!")
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
        .frame(maxWidth: .infinity, maxHeight: 130)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("완료") {
                    dismissKeyboard()
                }
                .foregroundColor(.blue)
                .font(.body.weight(.medium))
            }
        }
    }
}
