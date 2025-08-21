//
//  CommentField.swift
//  Component
//
//  Created by 김은찬 on 8/21/25.
//

import SwiftUI

public struct CommentField: View {
    @Binding var commentText: String
    
    public init(commentText: Binding<String>) {
        self._commentText = commentText
    }
    
    public var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                if #available(iOS 16.0, *) {
                    TextEditor(text: $commentText)
                        .font(.label(.medium))
                        .tint(LegacyColor.Common.white)
                        .scrollContentBackground(.hidden)
                        .scrollIndicators(.hidden)
                        .frame(height: 130)
                } else {
                    TextEditor(text: $commentText)
                        .font(.label(.medium))
                        .tint(LegacyColor.Common.white)
                        .frame(height: 130)
                }
                
                if commentText.isEmpty {
                    Text("유적지에 대한 감상을 입력해주세요!")
                        .font(.body2(.medium))
                        .foreground(LegacyColor.Label.alternative)
                        .padding(.top, 8)
                        .padding(.leading, 6)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 16)
        }
        .frame(maxWidth: .infinity, maxHeight: 130)
    }
}
