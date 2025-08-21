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
                .blur(radius: showDetail ? 2 : 0)
                .animation(.spring(response: 0.55, dampingFraction: 0.85), value: showDetail)
                .onTapGesture {
                    withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
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
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .trailing)
                                    .combined(with: .opacity)
                                    .combined(with: .scale(scale: 0.95, anchor: .trailing)),
                                removal: .move(edge: .trailing).combined(with: .opacity)
                            )
                        )
                } else {
                    RuinsDetailView(
                        data: detail,
                        onClose: { dismissDetail() },
                        action: action,
                        onComment: {
                            withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                                showComment = true
                            }
                        }
                    )
                    .padding(.horizontal, 4)
                    .padding(.bottom, 40)
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .leading)
                                .combined(with: .opacity)
                                .combined(with: .scale(scale: 0.95, anchor: .leading)),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        )
                    )
                }
            }
            .animation(.spring(response: 0.55, dampingFraction: 0.85), value: showComment)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.spring(response: 0.55, dampingFraction: 0.85), value: showDetail)
    }
    
    private func dismissDetail() {
        withAnimation(.spring(response: 0.55, dampingFraction: 0.9)) {
            showDetail = false
        }
        delayRun(0.25) {
            viewModel.ruinDetail = nil
        }
    }
}
