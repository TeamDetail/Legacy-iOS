//
//  CourseView.swift
//  Feature
//
//  Created by 김은찬 on 7/25/25.
//

import SwiftUI
import Component
import Data

struct CourseView: View {
    @Binding var tabItem: LegacyTabItem
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "코스", icon: .course, item: tabItem) {
            }
        }
    }
}
