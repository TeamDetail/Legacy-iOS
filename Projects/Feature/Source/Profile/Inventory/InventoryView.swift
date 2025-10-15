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
    @Binding var revealCard: Bool
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 7)
    
    var body: some View {
        VStack {
            if let data = viewModel.inventory {
                if data.isEmpty {
                    Text("인벤토리가 비었어요!")
                        .font(.title2(.bold))
                        .foreground(LegacyColor.Common.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(data, id: \.self) { item in
                            InventoryItem() {
                                viewModel.selectedItem = item
                            }
                        }
                    }
                }
            } else {
                LegacyLoadingView("")
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .task {
            await viewModel.fetchInventory()
        }
    }
}
