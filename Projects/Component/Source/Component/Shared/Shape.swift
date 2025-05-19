import SwiftUI

public extension View {
    func clipShape(size: CGFloat) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: size))
    }
}
