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
    @Binding var isTabBarHidden: Bool
    let viewModel: ExploreViewModel
    let action: () -> Void
    @State private var showComment = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        if showComment {
                            showComment = false
                        } else {
                            isTabBarHidden = false
                            dismissDetail()
                        }
                    }
                }
            
            ZStack {
                if showComment {
                    CommentView(detail)
                        .padding(.horizontal, 4)
                        .padding(.bottom, 40)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                } else {
                    RuinsDetailView(
                        data: detail,
                        onClose: { dismissDetail() },
                        action: action,
                        onComment: {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showComment = true
                            }
                        }
                    )
                    .padding(.horizontal, 4)
                    .padding(.bottom, 40)
                    .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeOut(duration: 0.25), value: showDetail)
    }
    
    private func dismissDetail() {
        withAnimation(.easeOut(duration: 0.2)) {
            showDetail = false
        }
        delayRun(0.2) {
            viewModel.ruinDetail = nil
        }
    }
}


