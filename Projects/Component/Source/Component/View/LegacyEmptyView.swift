//
//  LegacyEmptyView.swift
//  Component
//
//  Created by 김은찬 on 6/9/25.
//

import SwiftUI

public struct LegacyEmptyView: View {
    public init() {}
    public var body: some View {
        VStack {
            Text("다음 버전에서 만나요 👋")
                .foreground(LegacyColor.Common.white)
                .font(.bitFont(size: 25))
                .padding(.bottom, 20)
        }
    }
}
