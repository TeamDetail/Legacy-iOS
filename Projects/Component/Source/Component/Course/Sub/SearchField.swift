//
//  SearchField.swift
//  Component
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI

public struct SearchField: View {
    @Binding var searchText: String
    let fieldDescription: String
    let action: () -> Void
    
    public init(
        _ fieldDescription: String,
        searchText: Binding<String>,
        action: @escaping () -> Void
    ) {
        self.fieldDescription = fieldDescription
        self._searchText = searchText
        self.action = action
    }
    
    public var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Image(icon: .search)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foreground(LegacyColor.Label.normal)
                    .padding(.horizontal, 8)
                    .padding(.leading, 4)
            }
            
            ZStack {
                TextField("", text: $searchText)
                    .font(.label(.medium))
                    .tint(LegacyColor.Common.white)
                    .submitLabel(.search)
                    .frame(height: 40)
                    .onSubmit {
                        action()
                    }
                HStack {
                    if searchText.isEmpty {
                        Text(fieldDescription)
                            .font(.label(.medium))
                            .foreground(LegacyColor.Common.white)
                    }
                    Spacer()
                }
                .padding(.horizontal, 4)
            }
        }
        .frame(maxWidth: .infinity)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 12)
    }
}
