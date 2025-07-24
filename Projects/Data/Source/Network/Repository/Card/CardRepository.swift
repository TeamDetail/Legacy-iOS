//
//  CardRepository.swift
//  Data
//
//  Created by 김은찬 on 7/24/25.
//

import Domain
import Component

public protocol CardRepository {
    func fetchCards(_ region: RegionEnum) async throws -> [CardResponse]
}
