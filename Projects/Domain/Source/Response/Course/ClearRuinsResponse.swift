//
//  ClearRuinsResponse.swift
//  Domain
//
//  Created by 김은찬 on 9/7/25.
//

import Foundation

public struct ClearRuinsResponse: ResponseProtocol {
    public let clear: Bool
    public let data: RuinsDetailResponse
    
    public init(clear: Bool, data: RuinsDetailResponse) {
        self.clear = clear
        self.data = data
    }
}
