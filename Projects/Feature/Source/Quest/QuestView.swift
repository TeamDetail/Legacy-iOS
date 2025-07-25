//
//  QuestView.swift
//  Feature
//
//  Created by 김은찬 on 7/25/25.
//

import SwiftUI
import Component
import Data

struct QuestView: View {
    @State private var selection = 0
    @Binding var tabItem: LegacyTabItem
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "도전과제", icon: .medal, item: tabItem) {
                HStack {
                    CategoryButtonGroup(
                        categories: ["전체", "일일", "탐험", "숙현", "시련", "히든"],
                        selection: $selection
                    )
                    
                    Spacer()
                }
                .padding(.horizontal, 14)
            }
        }
    }
}

