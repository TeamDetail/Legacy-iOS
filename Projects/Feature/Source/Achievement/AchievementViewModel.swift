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
public final class AchievementViewModel: ObservableObject, Refreshable {
    @Published var achievementList: [AchievementResponse]?
    @Published var achievementAward: AchievementAwardResponse?
    @Published var achievementTypeList: [AchievementResponse]?
    
    @Inject var achievementRepository: any AchievementRepository
    
    func fetchAchievement() async {
        do {
            achievementList = try await achievementRepository.fetchAchievement()
        } catch let apiError as APIError {
            print("API Error:", apiError.message)
        } catch {
            print("에러:", error)
        }
    }
    
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
        achievementList = nil
        achievementTypeList = nil
    }
    
    func onRefresh() async {
        clearData()
        await fetchAchievement()
    }
}
