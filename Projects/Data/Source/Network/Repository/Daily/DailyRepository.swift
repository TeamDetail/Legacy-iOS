//
//  DailyRepository.swift
//  Data
//
//  Created by 김은찬 on 10/20/25.
//

import Foundation
import Domain

public protocol DailyRepository {
    func fetchDaily() async throws -> [DailyResponse]
    func postAward(_ dailyId: Int) async throws -> [InventoryResponse]
}

