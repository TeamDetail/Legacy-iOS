import SwiftUI
import Domain
import Kingfisher
import Shimmer
import FlowKit

private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

public struct RuinsDetailView: View {
    @Flow var flow
    public let data: RuinsDetailResponse
    public var onClose: (() -> Void)? = nil
    public let action: () -> Void
    
    @State private var scrollOffset: CGFloat = 0
    @State private var isExpanded: Bool = false
    
    private var dynamicHeight: CGFloat {
        isExpanded ? UIScreen.main.bounds.height * 0.75 : 400
    }
    
    public init(
        data: RuinsDetailResponse,
        onClose: (() -> Void)? = nil,
        action: @escaping () -> Void
    ) {
        self.data = data
        self.onClose = onClose
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .frame(width: 40, height: 6)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 8)
                .onTapGesture {
                    withAnimation { isExpanded.toggle() }
                }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    GeometryReader { geo in
                        Color.clear
                            .frame(height: 0)
                            .preference(
                                key: ScrollOffsetKey.self,
                                value: geo.frame(in: .named("scroll")).minY
                            )
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("유적지 탐험")
                            Text("유적지 탐험")
                            Text("유적지 탐험")
                            Text("유적지 탐험")
                            Text("유적지 탐험")
                            
                        }
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 160, height: 224)
                    }
                }
                .padding()
                
                ForEach(1...5, id: \.self) { _ in
                    Text("대통령의 임기연장 또는 중임변경을 위한 헌법개정은 그 헌법개정 제안 당시의 대통령에 대하여는 효력이 없다. 각급 선거관리위원회는 선거인명부의 작성등 선거사무와 국민투표사무에 관하여 관계 행정기관에 필요한 지시를 할 수 있다.")
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = value
                withAnimation(.easeInOut(duration: 0.3)) {
                    if value < -100 && !isExpanded {
                        isExpanded = true
                    } else if value > -10 && isExpanded {
                        isExpanded = false
                    }
                }
            }
            .frame(height: dynamicHeight)
            .animation(.easeInOut(duration: 0.3), value: dynamicHeight)
            .clipShape(size: 24)
            
            AnimationButton {
                action()
            } label: {
                Text("퀴즈 풀고 탐험하기")
                    .frame(maxWidth: .infinity)
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Blue.netural)
                    .padding(.vertical, 14)
                    .background(LegacyColor.Fill.netural)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Blue.netural)
                    )
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .padding(8)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 24)
        .shadow(radius: 10)
        .padding(.horizontal, 4)
    }
}
