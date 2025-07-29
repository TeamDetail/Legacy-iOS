//
//  BlockRepository.swift
//  Data
//
//  Created by 김은찬 on 7/29/25.
//

import RealmSwift

public protocol BlockRepository {
    func saveRuins(_ ruins: [RuinsObject])
    func fetchRuins() -> Results<RuinsObject>
    func saveBlocks(_ blocks: [BlockObject])
    func fetchBlocks() -> Results<BlockObject>
    func observeRuins(_ block: @escaping (RealmCollectionChange<Results<RuinsObject>>) -> Void) -> NotificationToken
    func observeBlocks(_ block: @escaping (RealmCollectionChange<Results<BlockObject>>) -> Void) -> NotificationToken
}
