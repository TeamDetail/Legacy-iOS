//
//  RuinsModalView.swift
//  Component
//
//  Created by 김은찬 on 7/12/25.
//

import SwiftUI
import Domain
import Component
import CoreLocation

struct RuinsDetailModal: View {
    @StateObject private var commentViewModel = CommentViewModel()
    @State private var showComment = false
    @State private var rating: Double = 0.0
    @State private var commentText: String = ""
    @Binding var showDetail: Bool
    
    let detail: RuinsDetailResponse
    let viewModel: ExploreViewModel
    @Binding var userLocation: CLLocation?
    
    let onShowDetail: () -> Void
    let onDismissDetail: () -> Void
    let action: () -> Void
    
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if showDetail {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .blur(radius: 2)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                            if showComment {
                                showComment = false
                            } else {
                                closeModal()
                            }
                        }
                    }
                
                ZStack {
                    if showComment {
                        CommentView(
                            detail,
                            rating: $rating,
                            commentText: $commentText
                        ) {
                            Task {
                                await commentViewModel.createComment(
                                    .init(
                                        ruinsId: detail.ruinsId,
                                        rating: rating,
                                        comment: commentText
                                    )
                                )
                                withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                                    showComment = false
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                        .padding(.bottom, 40)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity).combined(with: .scale(scale: 0.95, anchor: .trailing)),
                            removal: .move(edge: .trailing).combined(with: .opacity)
                        ))
                    } else {
                        RuinsDetailView(
                            data: detail,
                            commentData: commentViewModel.ruinComments,
                            onClose: { closeModal() },
                            onDismissDetail: {
                                closeModal()
                            }, action: action,
                            onComment: {
                                withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                                    showComment = true
                                }
                            },
                            userLocation: $userLocation
                        )
                        .id("Detail-\(UUID().uuidString)")
                        .padding(.horizontal, 4)
                        .padding(.bottom, 40)
                        .offset(y: offsetY)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.translation.height > 0 {
                                        offsetY = value.translation.height
                                    }
                                }
                                .onEnded { value in
                                    if value.translation.height > 30 {
                                        closeModal()
                                    } else {
                                        withAnimation(.spring()) {
                                            offsetY = 0
                                        }
                                    }
                                }
                        )
                        .transition(.asymmetric(
                            insertion: .move(edge: .leading).combined(with: .opacity).combined(with: .scale(scale: 0.95, anchor: .leading)),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                        .task {
                            await commentViewModel.fetchComment(detail.ruinsId)
                            onShowDetail()
                        }
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
    
    private func closeModal() {
        withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
            showDetail = false
            offsetY = 0
        }
        delayRun(0.25) {
            viewModel.ruinDetail = nil
            onDismissDetail()
        }
    }
}

