//
//  CourseDetailView.swift
//  Feature
//
//  Created by 김은찬 on 8/29/25.
//

import Domain
import SwiftUI
import FlowKit
import Component

struct CourseDetailView: View {
    @StateObject private var viewModel = CourseViewModel()
    @Flow var flow
    let courseId: Int
    var body: some View {
        ScrollView(showsIndicators: false) {
            if let data = viewModel.courseDetail {
                CourseDetailItem(data: data) {
                    Task {
                        await viewModel.likeCourse(data.courseId)
                    }
                }
            } else {
                ErrorCourseDetailItem()
            }
        }
        .backButton(title: "목록으로") {
            flow.pop()
        }
        .onAppear {
            Task {
                await viewModel.fetchCourseDatail(courseId)
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchCourseDatail(courseId)
            }
        }
    }
}
