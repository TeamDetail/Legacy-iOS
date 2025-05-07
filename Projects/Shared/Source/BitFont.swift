import SwiftUI

enum BitBit: String {
    case bitbit = "DNFBitBitOTF"
}

extension Font {
    public static func bitFont(size: CGFloat) -> Self {
        Font.custom(BitBit.bitbit.rawValue, size: size)
    }
}
