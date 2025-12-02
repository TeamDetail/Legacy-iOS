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
import Domain
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
    
    private var filteredCourses: [CourseResponse] {
        guard let courses = viewModel.courses else { return [] }
        return applySorting(to: applyContentFilter(to: applyProgressFilter(to: applySearchFilter(to: courses))))
    }
    
    private func applySearchFilter(to list: [CourseResponse]) -> [CourseResponse] {
        guard !searchText.isEmpty else { return list }
        return list.filter {
            $0.courseName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private func applyProgressFilter(to list: [CourseResponse]) -> [CourseResponse] {
        list.filter { course in
            switch selectedProgress {
            case .all:
                return true
            case .complete:
                return course.clear == true
            case .incomplete:
                return course.clear == false
            }
        }
    }
    
    private func applyContentFilter(to list: [CourseResponse]) -> [CourseResponse] {
        list.filter { course in
            switch selectedContent {
            case .all:
                return true
            case .general:
                return course.eventId == nil
            case .event:
                return course.eventId != nil
            }
        }
    }
    
    private func applySorting(to list: [CourseResponse]) -> [CourseResponse] {
        switch selectedSort {
        case .latest:
            return list.sorted { $0.courseId > $1.courseId }
        case .popular:
            return list.sorted { $0.heartCount > $1.heartCount }
        case .clearCount:
            return list.sorted { $0.clearCount > $1.clearCount }
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            CourseButton(title: "추천 페이지로 보기") {
                selection = 0
            }
            .padding(.horizontal, 8)
            
            VStack(spacing: 8) {
                SearchField("코스 이름으로 검색해주세요.", searchText: $searchText) {
                    isFocused = false
                }
                .focused($isFocused)
                .padding(.horizontal, 8)
                
                HStack {
                    DropDown(
                        isExpanded: Binding(
                            get: { activeDropDown == .progress },
                            set: { activeDropDown = $0 ? .progress : .none }
                        ),
                        selected: $selectedProgress,
                        button: .big
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DropDown(
                        isExpanded: Binding(
                            get: { activeDropDown == .sort },
                            set: { activeDropDown = $0 ? .sort : .none }
                        ),
                        selected: $selectedSort,
                        button: .small
                    )
                    
                    DropDown(
                        isExpanded: Binding(
                            get: { activeDropDown == .content },
                            set: { activeDropDown = $0 ? .content : .none }
                        ),
                        selected: $selectedContent,
                        button: .small
                    )
                }
                .zIndex(1)
                .padding(.horizontal, 8)
                
                if let _ = viewModel.courses {
                    ScrollView {
                        LazyVStack(spacing: 4) {
                            ForEach(filteredCourses, id: \.self) { data in
                                CourseItem(data: data) {
                                    Task { await viewModel.likeCourse(data.courseId) }
                                } navigation: {
                                    flow.push(CourseDetailView(courseId: data.courseId))
                                }
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    LegacyLoadingView()
                }
            }
        }
        .padding(4)
    }
}
