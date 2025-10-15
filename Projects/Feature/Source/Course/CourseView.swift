//
//  CourseView.swift
//  Feature
//
//  Created by 김은찬 on 7/25/25.
//

import SwiftUI
import Component
import Data
import FlowKit

struct CourseView: View {
    @StateObject var viewModel = CourseViewModel()
    @Flow var flow
    @State private var activeDropDown: DropDownType = .none
    @State private var selection = 0
    @FocusState private var isFocused: Bool
    @Binding var tabItem: LegacyTabItem
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "코스", icon: .course, item: tabItem) {
                if selection == 0 {
                    CourseMainView(
                        viewModel: viewModel,
                        selection: $selection
                    )
                } else {
                    CourseListView(
                        viewModel: viewModel,
                        activeDropDown: $activeDropDown,
                        selection: $selection,
                        isFocused: $isFocused
                    )
                }
            }
            .overlay(alignment: .bottomTrailing) {
                VStack {
                    AnimationButton {
                        flow.push(
                            CreateCourseView(
                                viewModel: viewModel
                            )
                        )
                    } label: {
                        ZStack {
                            Circle()
                                .foreground(LegacyColor.Primary.normal)
                                .frame(width: 60, height: 60)
                            
                            Image(icon: .pen)
                                .resizable()
                                .frame(width: 27, height: 27)
                                .foreground(LegacyColor.Common.white)
                        }
                    }
                }
                .padding(.bottom, 110)
                .padding(.horizontal, 14)
            }
            .onTapGesture {
                activeDropDown = .none
                isFocused = false
            }
            .task {
                await viewModel.fetchAllData()
            }
            .refreshable {
                Task {
                    await viewModel.fetchAllData()
                }
            }
        }
    }
}
