//
//  CourseTagItem.swift
//  Feature
//
//  Created by 김은찬 on 8/29/25.
//

import SwiftUI

public struct CourseTagItem: View {
    let tag: String
    
    public init(tag: String) {
        self.tag = tag
    }
    
    public var body: some View {
        Text("# \(tag)")
            .font(.body2(.medium))
            .foreground(LegacyColor.Common.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(height: 28)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 4)
    }
}
