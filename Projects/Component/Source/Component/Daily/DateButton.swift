//
//  DateButton.swift
//  Component
//
//  Created by 김은찬 on 10/20/25.
//

import SwiftUI

public struct DateButton: View {
    @Binding var isSelceted: Bool
    let lastDate: Bool
    let onSelect: () -> Void
    let date: Int
    
    public init(
        isSelceted: Binding<Bool>,
        lastDate: Bool,
        onSelect: @escaping () -> Void,
        date: Int
    ) {
        self._isSelceted = isSelceted
        self.lastDate = lastDate
        self.onSelect = onSelect
        self.date = date
    }
    
    public var body: some View {
        AnimationButton {
            onSelect()
            isSelceted.toggle()
        } label: {
            Text("\(date)")
                .font(.body2(.bold))
                .foreground(foregroundColor)
                .frame(width: 40, height: 40)
                .background(backgroundColor)
                .clipShape(size: 8)
        }
        .disabled(lastDate)
    }
}

// MARK: - Private Helpers
private extension DateButton {
    var foregroundColor: LegacyColorable {
        if lastDate {
            return LegacyColor.Label.assistive
        } else if isSelceted {
            return LegacyColor.Common.white
        } else {
            return LegacyColor.Common.white
        }
    }
    
    var backgroundColor: LegacyColorable {
        if lastDate {
            return LegacyColor.Fill.netural
        } else if isSelceted {
            return LegacyColor.Primary.normal
        } else {
            return LegacyColor.Fill.normal
        }
    }
}
