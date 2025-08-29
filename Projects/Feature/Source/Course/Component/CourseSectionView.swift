//
//  CourseSectionView.swift
//  Feature
//
//  Created by 김은찬 on 8/7/25.
//

import SwiftUI
import Component
import Shared

struct CourseSectionView<Data: Hashable, Content: View>: View {
    @Binding var selection: Int
    let sectionType: CourseSectionType
    let data: [Data]?
    let content: (Data) -> Content
    
    var body: some View {
        VStack(spacing: 6) {
            SectionHeaderView(sectionType: sectionType)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if let data = data {
                        ForEach(data, id: \.self) { item in
                            content(item)
                        }
                    } else {
                        ForEach(1...3, id: \.self) { _ in
                            CourseCardError()
                        }
                    }
                    DetailButton {
                        selection = 1
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
