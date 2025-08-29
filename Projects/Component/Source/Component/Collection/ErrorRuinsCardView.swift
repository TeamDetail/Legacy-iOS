//
//  ErrorRuinsCardView.swift
//  Component
//
//  Created by 김은찬 on 8/29/25.
//

import Kingfisher
import SwiftUI
import Shimmer
import Domain

public struct ErrorRuinsCardView: View {
    public init() {}
    public var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.3))
            .frame(maxWidth: .infinity)
            .aspectRatio(140/196, contentMode: .fit)
            .redacted(reason: .placeholder)
            .shimmering()
    }
}

#Preview {
    ErrorRuinsCardView()
}
