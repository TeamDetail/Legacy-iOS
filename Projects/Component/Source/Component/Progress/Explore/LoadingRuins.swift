//
//  LoadingRuins.swift
//  Component
//
//  Created by 김은찬 on 7/18/25.
//

import SwiftUI

public struct LoadingRuins: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            LegacyLoadingView(description: "유적지를 불러오는 중이에요..")
                .padding(24)
                .background(Color.black.opacity(0.7))
                .clipShape(size: 12)
        }
        .transition(.opacity)
    }
}

#Preview {
    LoadingRuins()
}
