//
//  AchievementRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 9/16/25.
//

import Foundation
import Domain

public struct AchievementRepositoryImpl: AchievementRepository {
    let dataSource: AchievementDataSource
    
    public init(dataSource: AchievementDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchAchievement() async throws -> [AchievementResponse] {
        let data = try await dataSource.fetchAchievement()
        return data
    }
    
    public func fetchAward() async throws -> AchievementAwardResponse {
        let data = try await dataSource.fetchAward()
        return data
    }
}
