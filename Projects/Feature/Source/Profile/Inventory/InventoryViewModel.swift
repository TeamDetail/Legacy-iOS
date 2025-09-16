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
    func openInventory(_ request: InventoryRequest) async {
        do {
            //            openedCards = try await inventoryRepository.openInventory(request)
            openedCards = [
                Card(cardId: 1, cardName: "미츠리", cardImageUrl: "https://p4.wallpaperbetter.com/wallpaper/553/884/886/kimetsu-no-yaiba-mitsuri-kanroji-hd-wallpaper-preview.jpg", cardType: .basic, nationAttributeName: "최고", lineAttributeName: "짱쩡", regionAttributeName: "역대급"),
                Card(cardId: 1, cardName: "미츠리", cardImageUrl: "https://p4.wallpaperbetter.com/wallpaper/553/884/886/kimetsu-no-yaiba-mitsuri-kanroji-hd-wallpaper-preview.jpg", cardType: .basic, nationAttributeName: "최고", lineAttributeName: "짱쩡", regionAttributeName: "역대급"),
                Card(cardId: 1, cardName: "미츠리", cardImageUrl: "https://p4.wallpaperbetter.com/wallpaper/553/884/886/kimetsu-no-yaiba-mitsuri-kanroji-hd-wallpaper-preview.jpg", cardType: .basic, nationAttributeName: "최고", lineAttributeName: "짱쩡", regionAttributeName: "역대급"),
                Card(cardId: 1, cardName: "미츠리", cardImageUrl: "https://p4.wallpaperbetter.com/wallpaper/553/884/886/kimetsu-no-yaiba-mitsuri-kanroji-hd-wallpaper-preview.jpg", cardType: .basic, nationAttributeName: "최고", lineAttributeName: "짱쩡", regionAttributeName: "역대급"),
            ]
        } catch {
            print("\(error) 에러")
        }
    }
}
