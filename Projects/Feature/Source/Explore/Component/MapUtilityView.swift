//
//  MapUtilityView.swift
//  Feature
//
//  Created by 김은찬 on 8/25/25.
//

import SwiftUI
import Component

struct MapUtilityView: View {
    @Binding var isPresented: Bool
    let locationAction: () -> Void
    let searchAction: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 8) {
                    LocationButton() {
                        locationAction()
                    }
                    SearchButton() {
                        searchAction()
                    }
                }
                
                Spacer()
                
                LegacyErrorAlert(
                    isPresented: $isPresented,
                    description: "줌을 많이 당기면 화면이\n멈출 수도 있어요!"
                )
            }
            .padding(.horizontal, 14)
        }
        .padding(.vertical, 4)
    }
}
