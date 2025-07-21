//
//  RankService.swift
//  Data
//
//  Created by 김은찬 on 7/19/25.
//

import Moya
import Domain

public enum RankService: ServiceProtocol {
    case fetchRanking
}

extension RankService {
    public var host: String {
        "/ranklist"
    }
    
    public var path: String {
        switch self {
        case .fetchRanking:
            "/explore/all"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchRanking: .get
        }
    }
     
    public var task: Moya.Task {
        switch self {
        case .fetchRanking: .requestPlain
        }
    }
}
