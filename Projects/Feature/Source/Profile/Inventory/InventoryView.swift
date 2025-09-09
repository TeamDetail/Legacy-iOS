//
//  InventoryView.swift
//  Feature
//
//  Created by 김은찬 on 9/9/25.
//

import Domain
import SwiftUI
import Component

struct InventoryView: View {
    @StateObject private var viewModel = InventoryViewModel()
    var body: some View {
        VStack {
            if let data = viewModel.inventory {
                ForEach(data, id: \.self) { item in
                    InventoryItem(action: {
                        
                    }, test: item.itemName)
                }
            } else {
                LegacyLoadingView(
                    description: ""
                )
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInventory()
            }
        }
    }
}

#Preview {
    InventoryView()
}
