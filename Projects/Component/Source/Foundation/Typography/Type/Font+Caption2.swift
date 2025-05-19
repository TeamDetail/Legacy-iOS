import SwiftUI

public extension Font {
    struct Caption2: LegacyTypography, Sendable {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let bold = Self.init(size: 12, weight: .bold)
        public static let medium = Self.init(size: 12, weight: .medium)
        public static let regular = Self.init(size: 12, weight: .regular)
    }
}
