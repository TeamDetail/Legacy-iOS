//
//  SettingView.swift
//  Feature
//
//  Created by dgsw27 on 5/14/25.
//

import Domain
import SwiftUI
import FlowKit
import Component

struct SettingView: View {
    @Flow var flow
    let viewModel: UserInfoResponse?
    @State private var selection = 0
   
    
    var body: some View {
        ScrollView {
            if let data = viewModel {
                ProfileComponent(data) {
                    
                }
            } else {
                ProfileError()
            }
            HStack {
                CategoryButtonGroup(
                    categories: ["내 기록", "칭호", "도감"],
                    selection: $selection
                )
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
