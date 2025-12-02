import SwiftUI
import Domain
import Kingfisher
import Shimmer

public struct CourseItem: View {
    let data: CourseResponse
    let action: () -> Void
    let navigation: () -> Void
    
    @State private var isHearted: Bool
    @State private var heartCount: Int
    
    private let imageHeight: CGFloat = 180
    private let cornerRadius: CGFloat = 8
    
    public init(
        data: CourseResponse,
        action: @escaping () -> Void,
        navigation: @escaping () -> Void
    ) {
        self.data = data
        self.action = action
        self.navigation = navigation
        self._isHearted = State(initialValue: data.heart)
        self._heartCount = State(initialValue: data.heartCount)
    }
    
    public var body: some View {
        AnimationButton {
            navigation()
        } label: {
            ZStack(alignment: .bottomLeading) {
                imageView
                    .frame(maxWidth: .infinity)
                    .frame(height: imageHeight)
                    .mask(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                
                content
                    .padding()
                    .frame(height: imageHeight, alignment: .bottom)
            }
        }
    }
}

// MARK: - Image Layer
private extension CourseItem {
    var imageView: some View {
        ZStack {
            if let url = URL(string: data.thumbnail) {
                KFImage(url)
                    .placeholder { placeholderView }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: imageHeight)
                    .clipped()
            } else {
                placeholderView
            }
            
            overlayGradients
                .frame(height: imageHeight)
                .allowsHitTesting(false)
        }
    }
    
    var placeholderView: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.3))
            .frame(maxWidth: .infinity)
            .frame(height: imageHeight)
            .redacted(reason: .placeholder)
            .shimmering()
    }
}

// MARK: - Gradient Overlay
private extension CourseItem {
    var overlayGradients: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .black.opacity(0.0), location: 0.0),
                    .init(color: .black.opacity(0.55), location: 0.7),
                    .init(color: .black.opacity(0.85), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .black.opacity(0.0), location: 0.0),
                    .init(color: .black.opacity(0.25), location: 0.4),
                    .init(color: .black.opacity(0.55), location: 1.0)
                ]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .blendMode(.multiply)
        }
        .mask(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

// MARK: - Content
private extension CourseItem {
    var content: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerSection
            Spacer()
            statSection
        }
        .foregroundColor(.white)
    }
    
    var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            if data.eventId != nil {
                EventTag(.big)
            }
            
            Text(data.courseName)
                .font(.title3(.bold))
                .foreground(LegacyColor.Label.normal)
            
            Text(data.description)
                .font(.label(.regular))
                .foreground(LegacyColor.Label.netural)
                .lineLimit(2)
        }
    }
    
    var statSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HeartStatItem(
                    isChecked: $isHearted,
                    statType: .heart,
                    text: "\(heartCount)",
                    size: .small
                ) {
                    if isHearted {
                        isHearted = false
                        heartCount -= 1
                    } else {
                        isHearted = true
                        heartCount += 1
                    }
                    action()
                }
                
                ClearStatItem(
                    statType: .flag,
                    text: "\(data.clearCount)",
                    isChecked: data.clear,
                    size: .small
                )
            }
            
            Spacer()
            
            CourseClearTag(current: CGFloat(data.clearCount))
                .frame(width: 84)
        }
    }
}
