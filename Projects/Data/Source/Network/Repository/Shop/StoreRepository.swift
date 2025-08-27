//
//  ShopRepository.swift
//  Data
//
//  Created by 김은찬 on 8/21/25.
//

import Foundation
import Domain

public protocol StoreRepository {
    func fetchStore() async throws -> StoreResponse
}
