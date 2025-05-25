//
//  SettingView.swift
//  Feature
//
//  Created by dgsw27 on 5/14/25.
//

import SwiftUI
import Component
import FlowKit

struct SettingView: View {
    @State private var selection = 0
    @Flow var flow
    var body: some View {
        ScrollView {
            ProfileComponent{ }
            HStack {
                CategoryButton(category: "내 기록", select: selection == 0) {
                    selection = 0
                }
                CategoryButton(category: "칭호", select: selection == 1) {
                    selection = 1
                }
                CategoryButton(category: "도감", select: selection == 2) {
                    selection = 2
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
            
            if selection == 0 {
                
            }
            
            if selection == 1 {
                
            }
            
            if selection == 2 {
                
            }
        }
        .padding(.horizontal, 10)
        .backButton {
            flow.pop()
        }
    }
}

#Preview {
    SettingView()
}
