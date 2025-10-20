//
//  DailyItem.swift
//  Component
//
//  Created by 김은찬 on 10/20/25.
//

import SwiftUI
import Domain

public struct DailyItem: View {
    let inventory: InventoryResponse
    
    public init(inventory: InventoryResponse) {
        self.inventory = inventory
    }
    
    public var body: some View {
        HStack {
            Text(inventory.itemName)
                .font(.caption1(.medium))
                .foreground(LegacyColor.Label.netural)
            
            Spacer()
            
            Text("\(inventory.itemCount)개")
                .font(.caption1(.medium))
                .foreground(LegacyColor.Label.netural)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
    }
}
