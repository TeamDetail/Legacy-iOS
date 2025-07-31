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
    @Flow var flow
    @FocusState private var isFocused: Bool
    @Binding var tabItem: LegacyTabItem
    @State private var selection = 0
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "코스", icon: .course, item: tabItem) {
                if selection == 0 {
                    CourseMainView(
                        selection: $selection
                    )
                } else {
                    CourseListView(
                        selection: $selection,
                        isFocused: $isFocused
                    )
                }
            }
            .overlay(alignment: .bottomTrailing) {
                VStack {
                    AnimationButton {
                        flow.push(EmptyView())
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
                isFocused = false
            }
        }
    }
}
