//
//  LegacyTopBar.swift
//  Feature
//
//  Created by dgsw30 on 5/5/25.
//

import Data
import Domain
import Shared
import SwiftUI
import FlowKit
import Shimmer
import Component
import Kingfisher

struct LegacyTopBar: View {
    @Flow var flow
    @Binding var showMenu: Bool
    @State private var showMail = false
    @State private var buttonFrame: CGRect = .zero
    @State private var showAnimation = false
    let data: UserInfoResponse
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                AnimationButton {
                    withAnimation(.appSpring) {
                        flow.push(ProfileView(data: data))
                    }
                } label: {
                    if let url = URL(string: data.imageUrl) {
                        KFImage(url)
                            .placeholder { _ in
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 140, height: 180)
                                    .redacted(reason: .placeholder)
                                    .shimmering()
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                            .clipShape(size: 50)
                    } else {
                        Circle()
                            .frame(width: 44, height: 44)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(data.nickname)
                            .font(.body2(.bold))
                            .foreground(LegacyColor.Label.normal)
                        Text("Lv.\(data.level)")
                            .font(.caption2(.bold))
                            .foreground(LegacyColor.Label.alternative)
                    }
                }
                
                Spacer()
                
                HStack {
                    Image(icon: .coin)
                    Text("\(data.credit)")
                        .font(.bitFont(size: 16))
                        .foreground(LegacyColor.Yellow.normal)
                }
                .padding(16)
                .background(LegacyColor.Fill.normal)
                .clipShape(size: 12)
                
                Button {
                    withAnimation(.spring(dampingFraction: 0.75)) {
                        HapticManager.instance.impact(style: .soft)
                        showMenu.toggle()
                    }
                } label: {
                    Image(icon: .menu)
                        .foreground(LegacyColor.Common.white)
                        .frame(width: 56, height: 56)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 12)
                }
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                buttonFrame = geo.frame(in: .global)
                            }
                            .onChange(of: geo.frame(in: .global)) { newFrame in
                                buttonFrame = newFrame
                            }
                    }
                )
            }
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity)
            .frame(height: 72)
            .background(LegacyColor.Background.normal)
            .clipShape(size: 20)
            .padding(.horizontal, 10)
            
            if showMenu {
                LegacyMenuBar { item in
                    switch item {
                    case .arrow:
                        withAnimation(.appSpring) {
                            showMenu = false
                        }
                    case .people:
                        print("사람")
                    case .mail:
                        withAnimation(.appSpring) {
                            showMail = true
                            showMenu = false
                        }
                    case .setting:
                        flow.push(SettingView())
                    case .wrong:
                        print("메일")
                    case .logout:
                        Sign.logout()
                    }
                }
                .id(UUID())
                .scaleEffect(showMenu ? 1.0 : 0.9, anchor: .top)
                .opacity(showMenu ? 1.0 : 0)
                .animation(.spring(response: 0.35, dampingFraction: 0.7), value: showMenu)
                .padding(.top, 7)
                .padding(.trailing, 16)
                .padding(.horizontal, 4)
            }
            
            if showMail {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .blur(radius: 2)
                        .onTapGesture {
                            withAnimation(.appSpring) {
                                showMail = false
                            }
                        }
                    
                    MailView {
                        withAnimation(.appSpring) {
                            showMail = false
                        }
                    }
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(1)
                }
                .animation(.spring(response: 0.35, dampingFraction: 0.7), value: showMail)
            }
        }
    }
}
