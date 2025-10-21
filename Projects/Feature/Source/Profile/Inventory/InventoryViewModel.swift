//
//  InventoryViewModel.swift
//  Feature
//
//  Created by 김은찬 on 9/9/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class InventoryViewModel: ObservableObject {
    @Published var inventory: [InventoryResponse]?
    @Published var openedCards: [Card]?
    @Published var selectedItem: InventoryResponse?
    
    @Inject var inventoryRepository: any InventoryRepository
    
    @MainActor
    func fetchInventory() async {
        do {
            inventory = try await inventoryRepository.fetchInventory()
        } catch {
            print("\(error) 에러")
        }
    }
    
    @MainActor
    func openInventory(_ request: InventoryCardpackRequest) async {
        do {
            openedCards = try await inventoryRepository.openInventory(request)
        } catch {
            print("\(error) 에러")
        }
    }
    
    @MainActor
    func openCredit(_ request: InventoryCreditRequest) async {
        do {
            try await inventoryRepository.openCredit(request)
        } catch {
            print("\(error) 에러")
        }
    }
}
