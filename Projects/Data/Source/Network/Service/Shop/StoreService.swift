//
//  StoreService.swift
//  Data
//
//  Created by 김은찬 on 8/21/25.
//

import Moya
import Domain
import Component

public enum StoreService: ServiceProtocol {
    case fetchStore
    case buyCard(_ cardpackId: Int)
}

extension StoreService {
    public var host: String {
        "/store"
    }
    
    public var path: String {
        switch self {
        case .fetchStore: ""
        case let .buyCard(cardpackId): "/cardBuy/\(cardpackId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchStore: .get
        case .buyCard: .patch
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchStore: .requestPlain
        case .buyCard: .requestPlain
        }
    }
}
