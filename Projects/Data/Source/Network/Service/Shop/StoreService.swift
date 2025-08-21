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
}

extension StoreService {
    public var host: String {
        "/store"
    }
    
    public var path: String {
        switch self {
        case .fetchStore: ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchStore: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchStore: .requestPlain
        }
    }
}
