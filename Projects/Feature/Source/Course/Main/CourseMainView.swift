//
//  CourseMainView.swift
//  Feature
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI
import Component
import Data

struct CourseMainView: View {
    @ObservedObject var viewModel: CourseViewModel
    @Binding var selection: Int
    
    var body: some View {
        VStack(spacing: 30) {
            CourseSectionView(
                selection: $selection,
                sectionType: .popular,
                data: viewModel.popularCourses,
                content: { data in
                    CourseCard(data: data) {
                        Task {
                            await viewModel.likeCourse(data.courseId)
                        }
                    }
                }
            )
            
            CourseSectionView(
                selection: $selection,
                sectionType: .event,
                data: viewModel.eventCourses,
                content: { data in
                    CourseCard(data: data) {
                        Task {
                            await viewModel.likeCourse(data.courseId)
                        }
                    }
                }
            )
            
            CourseSectionView(
                selection: $selection,
                sectionType: .recent,
                data: viewModel.recentCourses,
                content: { data in
                    CourseCard(data: data) {
                        Task {
                            await viewModel.likeCourse(data.courseId)
                        }
                    }
                }
            )
            
            VStack {
                CourseButton(title: "목록으로 보기") {
                    selection = 1
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(4)
    }
}

