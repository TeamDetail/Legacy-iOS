//
//  CommentView.swift
//  Component
//
//  Created by 김은찬 on 8/21/25.
//

import SwiftUI
import Domain
import Combine

public struct CommentView: View {
    @State private var keyboardHeight: CGFloat = 0
    @State private var rating: Double = 0.0
    @State private var commentText = ""
    @State private var isClicked = false
    @State private var isKeyboardFocused = false
    let data: RuinsDetailResponse
    
    public init(_ data: RuinsDetailResponse) {
        self.data = data
    }
    
    public var body: some View {
        ZStack {
            if isKeyboardFocused {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                            isKeyboardFocused = false
                            hideKeyboard()
                        }
                    }
                    .zIndex(1)
            }
            
            if isClicked {
                Color.clear
                    .contentShape(Rectangle())
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                            isClicked = false
                        }
                    }
                    .zIndex(4)
            }
            
            VStack(spacing: 20) {
                VStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("한줄평 남기기")
                            .font(.headline(.bold))
                            .foreground(LegacyColor.Common.white)
                        
                        Text("#\(data.ruinsId)")
                            .font(.caption1(.medium))
                            .foreground(LegacyColor.Label.alternative)
                        
                        Text(data.name)
                            .font(.headline(.bold))
                            .foreground(LegacyColor.Label.normal)
                    }
                    
                    Button {
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                            isClicked = true
                        }
                    } label: {
                        HStack(spacing: 6) {
                            ForEach(0..<5, id: \.self) { index in
                                HStack(spacing: 0) {
                                    Image(icon: .leftStar)
                                        .foreground(rating >= Double(index) + 0.5 ? LegacyColor.Primary.normal : LegacyColor.Common.white)
                                    Image(icon: .rightStar)
                                        .foreground(rating >= Double(index) + 1.0 ? LegacyColor.Primary.normal : LegacyColor.Common.white)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(8)
                
                CommentField(commentText: $commentText, isKeyboardFocused: $isKeyboardFocused)
                
                AnimationButton {
                    
                } label: {
                    Text("작성 완료!")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .font(.caption1(.bold))
                        .foreground(LegacyColor.Blue.netural)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Blue.netural)
                        )
                }
                .padding(.bottom, 8)
            }
            .padding(10)
            .background(LegacyColor.Background.netural)
            .clipShape(size: 24)
            .shadow(radius: 10)
            .padding(.horizontal, 4)
            .frame(maxHeight: .infinity, alignment: isKeyboardFocused ? .top : .bottom)
            .zIndex(isKeyboardFocused ? 3 : 0)
            .padding(.bottom, isKeyboardFocused ? 0 : 16)
            .padding(.top, isKeyboardFocused ? 80 : 0)
            
            if isClicked {
                CommentModal($rating) {
                    withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                        isClicked = false
                    }
                } onCancel: {
                    withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                        isClicked = false
                    }
                }
                .transition(.scale.combined(with: .opacity))
                .zIndex(5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isClicked)
        .animation(.spring(response: 0.55, dampingFraction: 0.85), value: isKeyboardFocused)
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let height = keyboardFrame.cgRectValue.height
                self.keyboardHeight = height
                withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                    isKeyboardFocused = true
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.keyboardHeight = 0
            withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                isKeyboardFocused = false
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
