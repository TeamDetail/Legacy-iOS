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

public class AchievementViewModel: ObservableObject, Refreshable {
    @Published var achievementList: [AchievementResponse]?
    
    @Inject var achievementRepository: any AchievementRepository
    
    @MainActor
    func fetchAchievement() async {
        do {
            achievementList = try await achievementRepository.fetchAchievement()
        } catch let apiError as APIError {
            print(apiError.message)
        } catch {
            print("에러: \(error)")
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAchievement()
    }
    
    func clearData() {
        achievementList = nil
    }
}

