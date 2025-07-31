//
//  SectionHeaderView.swift
//  Feature
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI
import Shared

struct SectionHeaderView: View {
    let sectionType: CourseSectionType
    
    var body: some View {
        HStack {
            Text(makeSectionTitle(sectionType))
                .font(.headline(.bold))
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 2)
    }
}
