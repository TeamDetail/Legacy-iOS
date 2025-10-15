//
//  AchievementService.swift
//  Data
//
//  Created by 김은찬 on 9/16/25.
//

import Moya
import Domain
import Component

public enum AchievementService: ServiceProtocol {
    case fetchAchievement
    case fetchAward
    case fetchAchievementType(_ categoryType: AchievementCategoryType)
}

extension AchievementService {
    public var host: String {
        "/achievement"
    }
    
    public var path: String {
        switch self {
        case .fetchAchievement:
            "/all"
        case .fetchAward:
            "/award"
        case let .fetchAchievementType(categoryType):
            "/\(categoryType.rawValue)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchAchievement: .get
        case .fetchAward: .post
        case .fetchAchievementType: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchAchievement: .requestPlain
        case .fetchAward: .requestPlain
        case .fetchAchievementType: .requestPlain
        }
    }
}
