import SwiftUI

public extension Image {
    init(icon: LegacyIconography) {
        self = Image(icon.rawValue, bundle: .module)
    }
}
