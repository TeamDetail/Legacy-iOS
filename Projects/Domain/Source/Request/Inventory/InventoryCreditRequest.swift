//
//  InventoryCreditRequest.swift
//  Domain
//
//  Created by 김은찬 on 10/22/25.
//

import Foundation

public struct InventoryCreditRequest: RequestProtocol {
    public let creditpackId: Int
    public let count: Int
    
    public init(creditpackId: Int, count: Int) {
        self.creditpackId = creditpackId
        self.count = count
    }
}

