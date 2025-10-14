//
//  AchievementDataSource.swift
//  Data
//
//  Created by 김은찬 on 9/16/25.
//

import Moya
import Domain

public struct AchievementDataSource: DataSourceProtocol {
    public typealias Target = AchievementService
    
    public init() {}
    
    public func fetchAchievement() async throws -> [AchievementResponse] {
        try await performRequest(.fetchAchievement)
    }
    
    public func fetchAward() async throws -> AchievementAwardResponse {
        try await performRequest(.fetchAward)
    }
}
