//
//  AchievementRepository.swift
//  Data
//
//  Created by 김은찬 on 9/16/25.
//

import Foundation
import Domain

public protocol AchievementRepository {
    func fetchAchievement() async throws -> [AchievementResponse]
}
