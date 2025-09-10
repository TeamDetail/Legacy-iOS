//
//  InventoryModal.swift
//  Component
//
//  Created by 김은찬 on 9/9/25.
//

import SwiftUI
import Domain

public struct InventoryModal: View {
    let data: InventoryResponse
    let action: () -> Void
    
    public init(_ data: InventoryResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 8) {
                VStack {
                    Image(systemName: "backpack.fill")
                        .foreground(LegacyColor.Common.white)
                }
                .frame(width: 108, height: 108)
                .background(LegacyColor.Fill.normal)
                .clipShape(size: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .foreground(LegacyColor.Line.alternative)
                )
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        Text(data.itemName)
                            .font(.heading1(.bold))
                            .foreground(LegacyColor.Common.white)
                        
                        Spacer()
                        
                        Text("\(data.itemCount)개 보유")
                            .font(.caption1(.bold))
                            .foreground(LegacyColor.Label.alternative)
                    }
                    
                    Text(data.itemDescription)
                        .font(.body2(.medium))
                        .foreground(LegacyColor.Label.netural)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
            }
            
            AnimationButton {
                action()
            } label: {
                Text("사용하기")
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Common.white)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Line.alternative)
                    )
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 212)
        .padding(.horizontal, 14)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
    }
}
