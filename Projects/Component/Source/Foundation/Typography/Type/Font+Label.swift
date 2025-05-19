import SwiftUI

public extension Font {
    struct Label: LegacyTypography, Sendable {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let bold = Self.init(size: 14, weight: .bold)
        public static let medium = Self.init(size: 14, weight: .medium)
        public static let regular = Self.init(size: 14, weight: .regular)
        public static let extraBold = Self.init(size: 14, weight: .extraBold)
    }
}
