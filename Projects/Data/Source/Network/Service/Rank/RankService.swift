//
//  RankService.swift
//  Data
//
//  Created by 김은찬 on 7/19/25.
//

import Moya
import Domain

public enum RankService: ServiceProtocol {
    case fetchLevelRanking(_ type: RankType)
    case fetchExploreRanking(_ type: RankType)
}

extension RankService {
    public var host: String {
        "/ranklist"
    }
    
    public var path: String {
        switch self {
        case let .fetchLevelRanking(type):
            "/level/\(type.rawValue)"
        case let .fetchExploreRanking(type):
            "/explore/\(type.rawValue)"
        }
    }
    
    public var method: Moya.Method {
        .get
    }
    
    public var task: Moya.Task {
        .requestPlain
    }
}
