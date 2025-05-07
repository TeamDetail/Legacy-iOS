import SwiftUI
import Legacy_DesignSystem

public struct Test: View {
    public var body: some View {
        VStack {
            Text("zz")
                .font(.heading1(.bold))
                .foreground(LegacyColor.Red.alternative)
        }
    }
}

#Preview {
    Test()
}
