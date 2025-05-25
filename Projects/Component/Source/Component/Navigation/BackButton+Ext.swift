import SwiftUI

public extension View {
    func backButton(
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(BackButton(action: action))
    }
}
