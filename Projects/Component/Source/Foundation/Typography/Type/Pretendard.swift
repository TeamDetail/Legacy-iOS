import SwiftUI

public struct Pretendard {
    public enum Weight: String, CaseIterable, Sendable {
        case bold = "Pretendard-Bold"
        case regular = "Pretendard-Regular"
        case medium = "Pretendard-Medium"
        case extraBold = "Pretendard-ExtraBold"
        case bitbit = "DNFBitBitOTF"
    }
    
    public static func register() {
        Pretendard.Weight.allCases.forEach {
            guard let fontURL = Bundle.module.url(
                forResource: $0.rawValue,
                withExtension: "otf"
            ),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else { return }
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
