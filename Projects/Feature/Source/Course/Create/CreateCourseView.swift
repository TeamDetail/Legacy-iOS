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
import Combine

struct CreateCourseView: View {
    @Flow var flow
    @ObservedObject var viewModel: CourseViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var searchText = ""
    @State private var tagList = [String]()
    @State private var ruinsIdList = [Int]()
    
    @FocusState private var isTitleFocused: Bool
    @FocusState private var isDescriptionFocused: Bool
    @FocusState private var isSearchFocused: Bool
    
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
                    TitleField(titleText: $title, isTextFieldFocused: $isTitleFocused)
                        .id("titleField")
                    
                    TagEditor(tagList: $tagList)
                    
                    CreateOptionView(.description)
                    
                    DescriptionField(descriptionText: $description, isTextEditorFocused: $isDescriptionFocused)
                        .id("descriptionField")
                    
                    VStack {
                        CreateOptionView(
                            .select,
                            isSelected: !viewModel.selectedRuins.isEmpty
                        ) {
                            viewModel.selectedRuins.removeAll()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            ZStack {
                                if !viewModel.selectedRuins.isEmpty {
                                    HStack {
                                        ForEach(viewModel.selectedRuins.indices, id: \.self) { index in
                                            let ruins = viewModel.selectedRuins[index]
                                            
                                            AnimationButton {
                                                viewModel.toggleSelection(ruins)
                                            } label: {
                                                VStack(spacing: 8) {
                                                    Text("\(index + 1)")
                                                        .font(.caption1(.bold))
                                                        .foreground(LegacyColor.Common.white)
                                                        .frame(maxWidth: .infinity)
                                                        .padding(.vertical, 4)
                                                        .background(LegacyColor.Fill.normal)
                                                        .clipShape(size: 12)
                                                    
                                                    if let card = ruins.card {
                                                        RuinCardView(data: card)
                                                    }
                                                }
                                                .frame(width: 120, height: 196)
                                            }
                                        }
                                    }
                                } else {
                                    Text("선택된 유적지가 없어요!")
                                        .font(.headline(.bold))
                                        .foreground(LegacyColor.Common.white)
                                        .frame(width: UIScreen.main.bounds.width - 32, height: 196)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                    
                    VStack(spacing: 12) {
                        SearchField("유적지 이름으로 검색해주세요.", searchText: $searchText) {
                            Task {
                                await viewModel.searchRuins(searchText)
                            }
                        }
                        .id("searchField")
                        .focused($isSearchFocused)
                        .padding(.horizontal, 8)
                        
                        if viewModel.isLoading {
                            LegacyLoadingView(description: "")
                        } else if let data = viewModel.searchResult {
                            ForEach(data, id: \.ruinsId) { item in
                                RuinsSearchItem(
                                    data: item,
                                    selectedRuins: viewModel.selectedRuins,
                                    onSelect: { selected in
                                        viewModel.toggleSelection(selected)
                                    }
                                )
                            }
                            .padding(.bottom, 12)
                        }
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 14)
                .padding(.bottom, keyboardHeight + 100)
            }
            .onChange(of: isTitleFocused) { focused in
                if focused {
                    withAnimation(.easeInOut) {
                        proxy.scrollTo("titleField", anchor: .top)
                    }
                }
            }
            .onChange(of: isDescriptionFocused) { focused in
                if focused {
                    withAnimation(.easeInOut) {
                        proxy.scrollTo("descriptionField", anchor: .top)
                    }
                }
            }
            .onChange(of: isSearchFocused) { focused in
                if focused {
                    withAnimation(.easeInOut) {
                        proxy.scrollTo("searchField", anchor: .top)
                    }
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    withAnimation(.easeOut(duration: 0.25)) {
                        keyboardHeight = keyboardFrame.cgRectValue.height
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                withAnimation(.easeOut(duration: 0.25)) {
                    keyboardHeight = 0
                }
            }
        }
        .overlay(alignment: .bottom) {
            AnimationButton {
                for ruins in viewModel.selectedRuins {
                    ruinsIdList.append(ruins.ruinsId)
                }
                Task {
                    await viewModel.createCourse(
                        .init(
                            name: title,
                            tag: tagList,
                            description: description,
                            ruinsId: ruinsIdList
                        )
                    )
                }
                flow.pop()
            } label: {
                Text("코스 제작 완료!")
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Blue.netural)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Blue.netural)
                    )
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
        }
        .backButton(title: "목록으로") {
            flow.pop()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("완료") {
                    hideKeyboard()
                }
                .foregroundColor(.blue)
                .font(.body.weight(.medium))
            }
        }
    }
    
    private func hideKeyboard() {
        isTitleFocused = false
        isDescriptionFocused = false
        isSearchFocused = false
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
