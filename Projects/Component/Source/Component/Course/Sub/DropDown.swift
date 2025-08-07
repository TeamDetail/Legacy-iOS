//
//  DropDown.swift
//  Component
//
//  Created by 김은찬 on 8/1/25.
//

import SwiftUI

public struct DropDown<T: CaseIterable & RawRepresentable>: View where T.RawValue == String {
    @Binding var isExpanded: Bool
    @Binding var selectedOption: T
    @State private var showAnimation = false
    
    let options: [T]
    let onSelection: (T) -> Void
    let buttonType: ButtonType
    
    public init(
        isExpanded: Binding<Bool>,
        selected: Binding<T>,
        options: [T] = Array(T.allCases),
        onSelection: @escaping (T) -> Void = { _ in },
        button: ButtonType = .small
    ) {
        self._isExpanded = isExpanded
        self._selectedOption = selected
        self.options = options
        self.onSelection = onSelection
        self.buttonType = button
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            AnimationButton {
                withAnimation(.easeOut(duration: 0.15)) {
                    isExpanded.toggle()
                    showAnimation = isExpanded
                }
            } label: {
                HStack(spacing: 6) {
                    Text(selectedOption.rawValue)
                        .font(.label(.medium))
                        .foreground(LegacyColor.Common.white)
                    
                    Image(icon: .topArrow)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foreground(LegacyColor.Common.white)
                        .rotationEffect(.degrees(isExpanded ? 0 : 180))
                }
                .frame(width: buttonType.widthSize, height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foreground(LegacyColor.Background.normal)
                )
            }
            .overlay(alignment: .top) {
                if isExpanded {
                    VStack(spacing: 0) {
                        ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                            Button {
                                selectedOption = option
                                onSelection(option)
                                withAnimation(.easeOut(duration: 0.15)) {
                                    isExpanded = false
                                    showAnimation = false
                                }
                            } label: {
                                HStack {
                                    Text(option.rawValue)
                                        .font(.label(.medium))
                                        .foreground(LegacyColor.Common.white)
                                }
                                .frame(width: buttonType.widthSize, height: 36)
                            }
                            .opacity(showAnimation ? 1 : 0)
                            .animation(.easeOut(duration: 0.2).delay(Double(index) * 0.03), value: showAnimation)
                        }
                    }
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foreground(LegacyColor.Background.normal)
                    )
                    .padding(.top, 40)
                }
            }
            .padding(.vertical, 8)
        }
        .frame(width: buttonType.widthSize)
    }
}

