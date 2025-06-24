import SwiftUI

public enum TitleBadgeSize {
    case small, medium, big
}

public struct TitleBadge: View {
    let title: String
    let color: LegacyColorable
    let size: TitleBadgeSize
    
    public init(_ title: String, color: LegacyColorable, size: TitleBadgeSize = .small) {
        self.title = title
        self.color = color
        self.size = size
    }
    
    public var body: some View {
        Text(title)
            .font(font)
            .foreground(color)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foreground(color)
            }
            .background(LegacyColor.Fill.normal)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(horizontalPadding)
    }
    
    private var font: Font {
        switch size {
        case .small, .medium:
            return .body1(.init(size: 10, weight: .extraBold))
        case .big:
            return .body2(.bold)
        }
    }
    
    private var height: CGFloat {
        switch size {
        case .small, .medium: return 20
        case .big: return 32
        }
    }
    
    private var horizontalPadding: EdgeInsets {
        switch size {
        case .small, .medium:
            return EdgeInsets()
        case .big:
            return EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 4)
        }
    }
}
