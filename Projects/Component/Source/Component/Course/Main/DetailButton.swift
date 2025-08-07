//
//  DetailButton.swift
//  Component
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI

public struct DetailButton: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            VStack {
                Text("클릭해서\n더보기")
            }
            .font(.caption1(.medium))
            .foreground(LegacyColor.Label.netural)
            .multilineTextAlignment(.center)
            .padding(8)
            .frame(width: 80, height: 220, alignment: .center)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14).opacity(0.2), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.14, green: 0.14, blue: 0.14), location: 1.0)
                    ],
                    startPoint: UnitPoint(x: 1.02, y: 0.5),
                    endPoint: UnitPoint(x: 0, y: 0.5)
                )
            )
            .clipShape(size: 20)
        }
    }
}
