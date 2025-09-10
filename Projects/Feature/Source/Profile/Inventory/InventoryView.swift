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
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 14), count: 7)
    @State private var showModal: Bool = false
    
    var body: some View {
        ScrollView {
            if let data = viewModel.inventory {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(data, id: \.self) { item in
                        InventoryItem() {
                            viewModel.selectedItem = item
                            withAnimation(.easeOut(duration: 0.2)) {
                                showModal = true
                            }
                        }
                        .frame(width: 40, height: 40)
                    }
                }
                .padding()
            } else {
                LegacyLoadingView(description: "")
            }
        }
        .overlay(alignment: .bottom) {
            VStack {
                Spacer()
                if showModal, let data = viewModel.selectedItem {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.2)) {
                                showModal = false
                            }
                        }
                        .transition(.opacity.animation(.easeInOut(duration: 0.2)))
                    
                    InventoryModal(data) {
                        withAnimation(.easeOut(duration: 0.2)) {
                            showModal = false
                        }
                    }
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.7)
                            .combined(with: .opacity.animation(.easeOut(duration: 0.1))),
                        removal: .scale(scale: 0.9)
                            .combined(with: .opacity.animation(.easeIn(duration: 0.15)))
                    ))
                }
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

