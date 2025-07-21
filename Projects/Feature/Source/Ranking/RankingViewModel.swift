//
//  LankingViewModel.swift
//  Feature
//
//  Created by 김은찬 on 7/19/25.
//

import Foundation
import DIContainer
import Domain
import Data

public class RankingViewModel: ObservableObject, Refreshable {
    @Published var rankingList: [RankResponse]?
    
    @Inject var rankingRepository: any RankRepository
    
    @MainActor
    func fetchRanking() async {
        do {
            rankingList = try await rankingRepository.fetchRanking()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchRanking()
    }
    
    func clearData() {
        rankingList = nil
    }
}
