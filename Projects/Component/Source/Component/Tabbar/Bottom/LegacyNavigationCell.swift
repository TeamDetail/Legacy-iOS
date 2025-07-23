import SwiftUI

public struct LegacyNavigationCell: View {
    let item: LegacyTabItem
    let isSelected: Bool
    let action: () -> Void
    
    public var body: some View {
        AnimationButton {
            HapticManager.instance.impact(style: .light)
            action()
        } label: {
            VStack(spacing: 2) {
                item.icon
                Text(item.label)
                    .font(.caption2(.medium))
            }
            .foreground(isSelected ? LegacyColor.Primary.normal : LegacyColor.Label.assistive)
        }
    }
}
