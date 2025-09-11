//
//  CreateCourseView.swift
//  Feature
//
//  Created by 김은찬 on 9/11/25.
//

import Domain
import SwiftUI
import FlowKit
import Component

struct CreateCourseView: View {
    @Flow var flow
    @ObservedObject var viewModel: CourseViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var tagList = [String]()
    
    @FocusState private var isTitleFocused: Bool
    @FocusState private var isDescriptionFocused: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                TitleField(
                    titleText: $title,
                    isTextFieldFocused: $isTitleFocused
                )
                
                TagEditor(tagList: $tagList)
                
                CreateOptionView("코스 설명")
                
                DescriptionField(
                    descriptionText: $description,
                    isTextEditorFocused: $isDescriptionFocused
                )
                
                CreateOptionView("선택된 유적지")
            }
            .padding(.top, 10)
            .padding(.horizontal, 14)
        }
        .backButton(title: "목록으로") {
            flow.pop()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("완료") {
                    isTitleFocused = false
                    isDescriptionFocused = false
                    hideKeyboard()
                }
                .foregroundColor(.blue)
                .font(.body.weight(.medium))
            }
        }
        .onTapGesture {
            isTitleFocused = false
            isDescriptionFocused = false
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
