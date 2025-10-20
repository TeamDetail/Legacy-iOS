//
//  DailyService.swift
//  Data
//
//  Created by 김은찬 on 10/20/25.
//

import Moya
import Domain

public enum DailyService: ServiceProtocol {
    case fetchDaily
    case postAward(_ dailyId: Int)
}

extension DailyService {
    public var host: String {
        "/daily"
    }
    
    public var path: String {
        switch self {
        case .fetchDaily: ""
        case let .postAward(dailyId): "/\(dailyId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchDaily: .get
        case .postAward: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchDaily: .requestPlain
        case let .postAward(dailyId): .requestJSONEncodable(dailyId)
        }
    }
}
