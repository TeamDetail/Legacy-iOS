//
//  CourseList.swift
//  Feature
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI
import Component
import Data
import Shared
import FlowKit

struct CourseListView: View {
    @ObservedObject var viewModel: CourseViewModel
    @State private var selectedProgress: ProgressStatus = .incomplete
    @State private var selectedSort: SortType = .latest
    @State private var selectedContent: ContentType = .all
    @State private var searchText = ""
    @Binding var activeDropDown: DropDownType
    @Binding var selection: Int
    @FocusState.Binding var isFocused: Bool
    @Flow var flow
    
    var body: some View {
        VStack(spacing: 16) {
            CourseButton(title: "추천 페이지로 보기") {
                selection = 0
            }
            .padding(.horizontal, 8)
            
            VStack(spacing: 8) {
                SearchField(searchText: $searchText) {
                    //MARK: 검색 기능 구현
                }
                .focused($isFocused)
                .padding(.horizontal, 8)
                
                HStack {
                    DropDown(
                        isExpanded: Binding(
                            get: { activeDropDown == .progress },
                            set: { newValue in
                                activeDropDown = newValue ? .progress : .none
                            }
                        ),
                        selected: $selectedProgress,
                        button: .big
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DropDown(
                        isExpanded: Binding(
                            get: { activeDropDown == .sort },
                            set: { newValue in
                                activeDropDown = newValue ? .sort : .none
                            }
                        ),
                        selected: $selectedSort,
                        button: .small
                    )
                    
                    DropDown(
                        isExpanded: Binding(
                            get: { activeDropDown == .content },
                            set: { newValue in
                                activeDropDown = newValue ? .content : .none
                            }
                        ),
                        selected: $selectedContent,
                        button: .small
                    )
                }
                .zIndex(1)
                .padding(.horizontal, 8)
                
                if let data = viewModel.courses {
                    LazyVStack(spacing: 4) {
                        ForEach(data, id: \.self) { data in
                            CourseItem(data: data) {
                                Task {
                                    await viewModel.likeCourse(data.courseId)
                                }
                            } navigation: {
                                flow.push(CourseDetailView(courseId: data.courseId))
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .zIndex(0)
                } else {
                    LegacyLoadingView(description: "")
                }
            }
        }
        .padding(4)
    }
}
