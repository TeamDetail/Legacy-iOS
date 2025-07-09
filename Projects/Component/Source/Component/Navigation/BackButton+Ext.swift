import SwiftUI

public extension View {
    func backButton(
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(BackButton(title: title, action: action))
    }
}
