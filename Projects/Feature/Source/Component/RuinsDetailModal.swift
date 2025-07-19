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
    let action: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissDetail()
                }
            
            RuinsDetailView(data: detail, onClose: {
                dismissDetail()
            }, action: {
                action()
            })
            .padding(.horizontal, 6)
            .padding(.bottom, 120)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeOut(duration: 0.25), value: showDetail)
    }
    
    private func dismissDetail() {
        withAnimation(.easeOut(duration: 0.2)) {
            showDetail = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { //TODO: cleanData 함수만들기
            viewModel.ruinDetail = nil
        }
    }
}
