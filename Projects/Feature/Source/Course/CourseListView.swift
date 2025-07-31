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

struct CourseListView: View {
    @State private var searchText = ""
    @Binding var selection: Int
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            CourseButton(title: "추천 페이지로 보기") {
                selection = 0
            }
            
            SearchField(searchText: $searchText) {
                //MARK: 검색 기능 구현
            }
            .focused($isFocused)
            
            
        }
        .padding(.horizontal, 20)
        .padding(4)
    }
}
