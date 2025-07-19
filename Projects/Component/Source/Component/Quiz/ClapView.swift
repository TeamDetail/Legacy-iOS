//
//  ClapView.swift
//  Component
//
//  Created by 김은찬 on 7/17/25.
//

import Kingfisher
import SwiftUI
import Shimmer
import Domain

public struct ClapView: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        LegacyModalView(action) {
            VStack(spacing: 15) {
                Spacer()
                
                Image(icon: .clap)
                    .padding(.bottom, 10)
                
                Text("축하해요!")
                    .font(.title2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text("퀴즈를 모두 맞추다니.. 대단해요!")
                    .font(.headline(.medium))
                    .foreground(LegacyColor.Label.alternative)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 40)
        }
        .onAppear {
            delayRun(2) {
                action()
            }
        }
    }
}
