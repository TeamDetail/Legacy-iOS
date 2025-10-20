import SwiftUI
import Domain
import Kingfisher
import Shimmer

private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

public struct RuinsDetailView: View {
    public let data: RuinsDetailResponse
    public var onClose: (() -> Void)? = nil
    public let action: () -> Void
    public let onComment: (() -> Void)?
    public let commentData: [CommentResponse]?
    
    @State private var scrollOffset: CGFloat = 0
    @State private var isExpanded: Bool = false
    
    private var dynamicHeight: CGFloat {
        isExpanded ? UIScreen.main.bounds.height * 0.75 : 400
    }
    
    public init(
        data: RuinsDetailResponse,
        commentData: [CommentResponse]?,
        onClose: (() -> Void)? = nil,
        action: @escaping () -> Void,
        onComment: (() -> Void)? = nil
    ) {
        self.commentData = commentData
        self.data = data
        self.onClose = onClose
        self.action = action
        self.onComment = onComment
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
                    
                    RuinsDetailContent(
                        data: data,
                        onComment: { onComment?() }
                    )
                    
                }
                .padding(.horizontal, 6)
                .padding(.bottom, 14)
                
                Text(data.description)
                    .font(.body2(.medium))
                    .foreground(LegacyColor.Label.normal)
                    .padding(.horizontal, 8)
                
                LegacyDivider()
                
                if let commentData {
                    ForEach(commentData, id: \.self) { data in
                        CommentItem(data: data)
                    }
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
            .padding(.horizontal, 4)
            .padding(.bottom, 8)
        }
        .padding(6)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 24)
        .shadow(radius: 10)
        .padding(.horizontal, 4)
    }
}
