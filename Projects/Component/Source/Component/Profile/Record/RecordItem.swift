//
//  RecordItem.swift
//  Component
//
//  Created by 김은찬 on 7/9/25.
//

import SwiftUI

struct RecordItem: View {
    let data: Int
    let recordType: RecordItemEnum
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(recordType.title)
                    .font(.body2(.bold))
                    .foreground(LegacyColor.Label.alternative)
                Spacer()
            }
            
            Text("\(data) \(recordType.description)")
                .font(.body1(.bold))
                .foreground(LegacyColor.Label.normal)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 4)
                .background(LegacyColor.Fill.normal)
                .clipShape(size: 8)
        }
    }
}
