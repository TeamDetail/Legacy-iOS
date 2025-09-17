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
}

extension AchievementService {
    public var host: String {
        "/achievement"
    }
    
    public var path: String {
        switch self {
        case .fetchAchievement:
            "/all"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchAchievement: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchAchievement: .requestPlain
        }
    }
}
