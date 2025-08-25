//
//  LocationButton.swift
//  Component
//
//  Created by 김은찬 on 8/25/25.
//

import SwiftUI

public struct LocationButton: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            VStack {
                Image(icon: .mapPin)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
            }
            .frame(width: 40, height: 40, alignment: .center)
            .background(LegacyColor.Background.normal)
            .clipShape(size: 8)
        }
    }
}
