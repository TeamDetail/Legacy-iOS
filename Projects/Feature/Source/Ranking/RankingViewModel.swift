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

@MainActor
public class RankingViewModel: ObservableObject {
    @Published var exploreRanking: [ExploreRankingResponse]? = nil
    @Published var levelRanking: [LevelRankingResponse]? = nil
    
    @Inject var rankingRepository: any RankRepository
    
    func fetchRanking(isExplore: Bool, type: RankType) async {
        exploreRanking = nil
        levelRanking = nil
        do {
            if isExplore {
                exploreRanking = try await rankingRepository.fetchExploreRanking(type)
            } else {
                levelRanking = try await rankingRepository.fetchLevelRanking(type)
            }
        } catch let apiError as APIError {
            print("API 에러: \(apiError)")
        } catch {
            print("에러: \(error)")
        }
    }
}
