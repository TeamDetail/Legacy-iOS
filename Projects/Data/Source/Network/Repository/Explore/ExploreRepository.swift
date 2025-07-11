//
//  ExploreRepository.swift
//  Data
//
//  Created by 김은찬 on 6/19/25.
//

import Foundation
import Domain

public protocol ExploreRepository {
    func fetchMap(_ requst: MapBoundsRequest) async throws -> [RuinsPositionResponse]
    func fetchRuinDeatil(_ id: Int) async throws -> RuinsDetailResponse
    func createBlock(_ request: CreateBlockRequest) async throws -> CreateBlockResponse
    func fetchMyBlock() async throws -> [CreateBlockResponse]
}
