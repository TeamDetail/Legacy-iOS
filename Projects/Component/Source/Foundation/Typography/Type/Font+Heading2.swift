import SwiftUI

public extension Font {
    struct Heading2: LegacyTypography, Sendable {
        public var size: CGFloat
        public var weight: Pretendard.Weight
        
        public static let bold = Self.init(size: 20, weight: .bold)
        public static let medium = Self.init(size: 20, weight: .medium)
        public static let regular = Self.init(size: 20, weight: .regular)
    }
}
