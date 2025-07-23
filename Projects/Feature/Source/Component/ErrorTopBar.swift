import Data
import Domain
import SwiftUI
import FlowKit
import Shimmer
import Component

struct ErrorTopBar: View {
    @State private var showMenu = false
    @State private var buttonFrame: CGRect = .zero
    @Flow var flow
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Circle()
                    .frame(width: 44, height: 44)
                    .redacted(reason: .placeholder)
                    .shimmering()
                
                VStack(alignment: .leading) {
                    Text("unknown")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Label.normal)
                        .redacted(reason: .placeholder)
                        .shimmering()
                    
                    Text("Lv.0")
                        .font(.caption2(.bold))
                        .foreground(LegacyColor.Label.alternative)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
                
                Spacer()
                
                HStack {
                    Image(icon: .coin)
                    Text("0")
                        .font(.bitFont(size: 16))
                        .foreground(LegacyColor.Yellow.normal)
                }
                .padding(16)
                .background(LegacyColor.Fill.normal)
                .clipShape(size: 12)
                
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        HapticManager.instance.impact(style: .light)
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
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            showMenu = false
                        }
                    case .people:
                        print("사람")
                    case .mail:
                        print("메일")
                    case .setting:
                        print("설정")
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
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                showMenu = false
            }
        }
    }
}


