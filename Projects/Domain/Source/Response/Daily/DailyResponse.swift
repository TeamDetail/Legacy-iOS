//
//  DailyResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/20/25.
//

import Foundation

public struct DailyResponse: ResponseProtocol {
    public let id: Int
    public let name: String
    public let startAt: String
    public let endAt: String
    public let awards: [[InventoryResponse]]
    public let checkCount: Int
    
    public init(id: Int, name: String, startAt: String, endAt: String, awards: [[InventoryResponse]], checkCount: Int) {
        self.id = id
        self.name = name
        self.startAt = startAt
        self.endAt = endAt
        self.awards = awards
        self.checkCount = checkCount
    }
}
