//
//  AchievementViewModel.swift
//  Feature
//
//  Created by 김은찬 on 9/17/25.
//

import Foundation
import DIContainer
import Domain
import Data

@MainActor
public final class AchievementViewModel: ObservableObject {
    @Published var achievementAward: AchievementAwardResponse?
    @Published var achievementTypeList: [AchievementResponse]?
    
    @Inject var achievementRepository: any AchievementRepository
    
    func fetchAward() async {
        do {
            achievementAward = try await achievementRepository.fetchAward()
        } catch {
            print("에러:", error)
        }
    }
    
    func fetchAchievementType(_ categoryType: AchievementCategoryType) async {
        do {
            achievementTypeList = try await achievementRepository.fetchAchievementType(categoryType)
        } catch {
            print("에러:", error)
        }
    }
    
    func clearData() {
        achievementTypeList = nil
    }
    
    func onRefresh(category: AchievementCategoryType) async {
        clearData()
        await fetchAchievementType(category)
    }
    
    private func categoryType(for selection: Int) -> AchievementCategoryType {
        switch selection {
        case 0: return .explore
        case 1: return .level
        case 2: return .hidden
        default: return .explore
        }
    }
}
