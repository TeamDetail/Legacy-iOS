//
//  QuizNotExist.swift
//  Component
//
//  Created by 김은찬 on 7/19/25.
//

import SwiftUI

public struct QuizNotExist: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("퀴즈가 존재하지 않습니다.")
                .font(.title3(.medium))
                .foreground(LegacyColor.Label.alternative)
                .multilineTextAlignment(.center)
                .padding()
            
            
            QuizButton(
                title: "닫기",
                buttonType: .cancel
            ) {
                action()
            }
            
            Spacer()
        }
    }
}
