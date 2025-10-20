//
//  DailyViewModel.swift
//  Feature
//
//  Created by 김은찬 on 10/20/25.
//

import Foundation
import DIContainer
import Domain
import Data

class DailyViewModel: ObservableObject {
    @Published var myDaily: [DailyResponse]?
    @Published var rewardDailies: [InventoryResponse]?
    @Published var selectDaily: DailyResponse?
    @Inject var dailyRepository: any DailyRepository
    
    @MainActor
    func fetchDaily() async {
        do {
            myDaily = try await dailyRepository.fetchDaily()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func postAward(_ dailyId: Int) async {
        do {
            rewardDailies = try await dailyRepository.postAward(dailyId)
        } catch {
            print(error.localizedDescription)
        }
    }
}
