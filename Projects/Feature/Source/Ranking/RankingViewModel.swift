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

public class RankingViewModel: ObservableObject {
    @Published var rankingList: [RankResponse]?
    @Inject var rankingRepository: any RankRepository
    
    @MainActor
    func fetchRanking(isExplore: Bool, type: RankType) async {
        do {
            if isExplore {
                rankingList = try await rankingRepository.fetchExploreRanking(type)
            } else {
                rankingList = try await rankingRepository.fetchLevelRanking(type)
            }
        } catch let apiError as APIError {
            print(apiError)
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func onRefresh(isExplore: Bool, type: RankType) async {
        await fetchRanking(isExplore: isExplore, type: type)
    }
    
}
