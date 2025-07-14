//
//  SettingView.swift
//  Feature
//
//  Created by 김은찬 on 7/14/25.
//

import SwiftUI
import FlowKit
import Component

struct SettingView: View {
    @Flow var flow
    var body: some View {
        VStack {
            
        }
        Spacer()
            .backButton(title: "설정") {
                flow.pop()
            }
    }
}

#Preview {
    SettingView()
}
