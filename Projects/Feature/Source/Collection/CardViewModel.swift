//
//  CardViewModel.swift
//  Feature
//
//  Created by 김은찬 on 7/24/25.
//

import Foundation
import DIContainer
import Component
import Domain
import Data

public class CardViewModel: ObservableObject {
    @Published var regionCardMap: [RegionEnum: CardResponse] = [:]
    @Inject var cardRepository: any CardRepository
    
    @MainActor
    func fetchAllCards() async {
        do {
            var tempMap: [RegionEnum: CardResponse] = [:]
            try await withThrowingTaskGroup(of: (RegionEnum, CardResponse).self) { group in
                for region in RegionEnum.allCases {
                    group.addTask {
                        let response = try await self.cardRepository.fetchCards(region)
                        return (region, response)
                    }
                }
                for try await (region, response) in group {
                    tempMap[region] = response
                }
            }
            regionCardMap = tempMap
        } catch {
            print("에러 발생: \(error)")
        }
    }
}
