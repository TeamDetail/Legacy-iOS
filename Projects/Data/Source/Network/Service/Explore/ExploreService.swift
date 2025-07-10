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
    case createBlock(_ requset: CreateBlockRequest)
}

extension ExploreService {
    public var host: String {
        "/ruins"
    }
    
    public var path: String {
        switch self {
        case .fetchMap: "/map"
        case .fetchRuinDeatil(let id): "\(id)"
        case .createBlock: "/block"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMap: .get
        case .fetchRuinDeatil: .get
        case .createBlock: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .fetchMap(request):
            request.toRequestParameters(
                encoding: URLEncoding.default
            )
        case .fetchRuinDeatil(_ ): .requestPlain
        case let .createBlock(request):
            request.toRequestParameters(
                encoding: URLEncoding.default
            )
        }
        
    }
}
