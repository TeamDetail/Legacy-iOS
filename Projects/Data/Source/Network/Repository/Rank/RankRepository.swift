//
//  RankRepository.swift
//  Data
//
//  Created by 김은찬 on 7/19/25.
//

import Foundation
import Domain

public protocol RankRepository {
    func fetchRanking() async throws -> [RankResponse]
}
