//
//  ExploreService.swift
//  Data
//
//  Created by 김은찬 on 6/17/25.
//

import Moya
import Domain

public enum ExploreService: ServiceProtocol {
    case fetchMap(_ request: MapBoundsRequest)
    case fetchRuinDeatil(_ id: Int)
}

extension ExploreService {
    public var host: String {
        "/ruins"
    }
    
    public var path: String {
        switch self {
        case .fetchMap: "/map"
        case .fetchRuinDeatil(let id): "\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMap: .get
        case .fetchRuinDeatil: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .fetchMap(request):
            request.toRequestParameters(
                encoding: URLEncoding.default
            )
        case .fetchRuinDeatil(_ ): .requestPlain
        }
    }
}
