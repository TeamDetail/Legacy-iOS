//
//  InventoryService.swift
//  Data
//
//  Created by 김은찬 on 9/9/25.
//

import Foundation
import Moya
import Domain

public enum InventoryService: ServiceProtocol {
    case fetchInventory
    case openInventory(_ request: InventoryCardpackRequest)
    case openCredit(_ request: InventoryCreditRequest)
}

extension InventoryService {
    public var host: String {
        "/inventory"
    }
    
    public var path: String {
        switch self {
        case .fetchInventory: ""
        case .openInventory: "/cardpack"
        case .openCredit: "/credit-pack/use"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchInventory: .get
        case .openInventory: .post
        case .openCredit: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchInventory:
            return .requestPlain
        case let .openInventory(request):
            return .requestJSONEncodable(request)
        case let .openCredit(request):
            return .requestJSONEncodable(request)
        }
    }
}
