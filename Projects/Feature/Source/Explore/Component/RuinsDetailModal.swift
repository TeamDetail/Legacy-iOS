//
//  RuinsModalView.swift
//  Component
//
//  Created by 김은찬 on 7/12/25.
//

import SwiftUI
import Domain
import Component

struct RuinsDetailOverlay: View {
    let detail: RuinsDetailResponse
    @Binding var showDetail: Bool
    let viewModel: ExploreViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissDetail()
                }
            
            RuinsDetailView(data: detail) {
                dismissDetail()
            }
            .padding(.horizontal, 6)
            //                        .padding(.bottom, 4) //MARK: google Map 보여줄때
            .padding(.bottom, 120) // TODO: 추후 동적으로 계산하도록 개선
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: showDetail)
        }
    }
    
    private func dismissDetail() {
        withAnimation {
            showDetail = false
            viewModel.ruinDetail = nil
        }
    }
}

