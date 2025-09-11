//
//  TagField.swift
//  Component
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI

struct TagField: View {
    @Binding var tagText: String
    @FocusState.Binding var isTextFieldFocused: Bool
    
    public init(
        tagText: Binding<String>,
        isTextFieldFocused: FocusState<Bool>.Binding
    ) {
        self._tagText = tagText
        self._isTextFieldFocused = isTextFieldFocused
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Text("#")
                .font(.body2(.medium))
                .foreground(LegacyColor.Common.white)
            
            ZStack(alignment: .leading) {
                if tagText.isEmpty {
                    Text("태그 입력..")
                        .font(.body2(.medium))
                        .foreground(LegacyColor.Label.alternative)
                        .padding(.leading, 2)
                }
                
                TextField("", text: $tagText)
                    .font(.body2(.medium))
                    .tint(LegacyColor.Common.white)
                    .submitLabel(.done)
                    .focused(_isTextFieldFocused)
                    .frame(width: 96, height: 35)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .frame(height: 35)
        .background(LegacyColor.Fill.normal)
        .clipShape(size: 4)
    }
}


