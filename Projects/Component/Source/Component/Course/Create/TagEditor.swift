//
//  TagEditor.swift
//  Component
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI

public struct TagEditor: View {
    @Binding var tagList: [String]
    @State private var isAddingTag = false
    @State private var newTag = ""
    @FocusState private var isTagFieldFocused: Bool
    
    public init(tagList: Binding<[String]>) {
        self._tagList = tagList
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(tagList, id: \.self) { tag in
                    Text("# \(tag)")
                        .font(.body2(.medium))
                        .foreground(LegacyColor.Common.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .frame(height: 35)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 6)
                }
                
                if isAddingTag {
                    TagField(
                        tagText: $newTag,
                        isTextFieldFocused: $isTagFieldFocused
                    )
                    .onSubmit {
                        addTag()
                    }
                    .onChange(of: isTagFieldFocused) { focused in
                        if !focused {
                            addTag()
                        }
                    }
                    .onAppear {
                        isTagFieldFocused = true
                    }
                } else {
                    AnimationButton {
                        isAddingTag = true
                    } label: {
                        VStack {
                            if #available(iOS 16.0, *) {
                                Image(systemName: "plus")
                                    .fontWeight(.bold)
                                    .foreground(LegacyColor.Common.white)
                            } else {}
                        }
                        .frame(width: 35, height: 35)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 6)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 8)
        }
    }
    
    private func addTag() {
        let trimmed = newTag.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            tagList.append(trimmed)
        }
        newTag = ""
        isAddingTag = false
    }
}

