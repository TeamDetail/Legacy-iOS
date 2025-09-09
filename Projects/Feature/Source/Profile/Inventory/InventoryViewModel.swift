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
    @Inject var inventoryRepository: any InventoryRepository
    
    
    func fetchInventory() async {
        do {
            inventory = try await inventoryRepository.fetchInventory()
        } catch {
            print("\(error) 에러")
        }
    }
    
    func openInventory(_ request: InventoryRequest) async {
        do {
            openedCards = try await inventoryRepository.openInventory(request)
        } catch {
            print("\(error) 에러")
        }
    }
}
