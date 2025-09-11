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
    @ObservedObject var viewModel: InventoryViewModel
    @Binding var showInventory: Bool
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 7)
    
    var body: some View {
        VStack {
            if let data = viewModel.inventory {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(data, id: \.self) { item in
                        InventoryItem() {
                            viewModel.selectedItem = item
                            withAnimation(.easeOut(duration: 0.2)) {
                                showInventory = true
                            }
                        }
                    }
                }
            } else {
                LegacyLoadingView(description: "")
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .onAppear {
            Task {
                await viewModel.fetchInventory()
            }
        }
    }
}

