//
//  CardService.swift
//  Data
//
//  Created by 김은찬 on 7/24/25.
//

import Moya
import Domain
import Component

public enum CardService: ServiceProtocol {
    case fetchCards(_ region: RegionEnum)
}

extension CardService {
    public var host: String {
        "/card"
    }
    
    public var path: String {
        switch self {
        case .fetchCards(let region): "/collection/\(region.regionName)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchCards: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchCards: .requestPlain
        }
    }
}
