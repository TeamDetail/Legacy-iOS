//
//  StoreDataSource.swift
//  Data
//
//  Created by 김은찬 on 8/21/25.
//

import Foundation
import Domain

public struct StoreDataSource: DataSourceProtocol {
    public typealias Target = StoreService
    
    public init() {}
    
    public func fetchStore() async throws -> [StoreResponse] {
        let response: BaseResponse<[StoreResponse]> = try await self.request(target: .fetchStore)
        return response.data
    }
}
