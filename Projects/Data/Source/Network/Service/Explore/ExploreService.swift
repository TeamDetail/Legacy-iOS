//
//  ExploreService.swift
//  Data
//
//  Created by 김은찬 on 6/17/25.
//

import Moya
import Domain

public enum ExploreService: ServiceProtocol {
    case fetchMap(_ request: ExploreRequest)
}

extension ExploreService {
    public var host: String {
        switch self {
        case .fetchMap:
            "/ruins"
        }
    }
    
    public var path: String {
        switch self {
        case .fetchMap: "/map"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMap: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .fetchMap(request):
            request.toJSONParameters()
        }
    }
    
    
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        .none
    }
    
}
