import SwiftUI

public struct TitleBadge: View {
    let title: String
    let styleId: Int
    
    public init(title: String, styleId: Int) {
        self.title = title
        self.styleId = styleId
    }
    
    public var body: some View {
        Text(title.uppercased())
            .font(.caption1(.bold))
            .foreground(LegacyColor.Common.white)
            .frame(maxWidth: .infinity)
            .frame(height: 20)
            .background(badgeColor)
            .clipShape(ParallelogramShape())
    }
    
    private var badgeColor: Color {
        switch styleId {
        case 1: return Color(0xFF9B6CFF) // 보라
        case 2: return Color(0xFFEB6E61) // 주황빛 레드
        case 3: return Color(0xFFEFC44A) // 노랑
        case 4: return Color(0xFF6DA8E5) // 하늘
        case 5: return Color(0xFF4D7A4E) // 초록
        default: return Color(0xFF9B6CFF) // 기본 보라
        }
    }
}

// MARK: - Parallelogram Shape (양쪽 각진 도형)
struct ParallelogramShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cut: CGFloat = rect.height / 2 // 각진 부분의 깊이
        path.move(to: CGPoint(x: cut, y: 0))
        path.addLine(to: CGPoint(x: rect.width - cut, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width - cut, y: rect.height))
        path.addLine(to: CGPoint(x: cut, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height / 2))
        path.closeSubpath()
        return path
    }
}
