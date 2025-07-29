//
//  DataServiceProtocol.swift
//  Data
//
//  Created by 김은찬 on 7/29/25.
//

import RealmSwift

public final class BlockService: BlockRepository {
    private let realmManager = RealmManager.shared
    
    public init() {}
    
    public func saveRuins(_ ruins: [RuinsObject]) {
        realmManager.saveRuins(ruins)
    }
    
    public func fetchRuins() -> Results<RuinsObject> {
        realmManager.fetchRuins()
    }
    
    public func saveBlocks(_ blocks: [BlockObject]) {
        realmManager.saveBlocks(blocks)
    }
    
    public func fetchBlocks() -> Results<BlockObject> {
        realmManager.fetchBlocks()
    }
    
    public func observeRuins(_ block: @escaping (RealmCollectionChange<Results<RuinsObject>>) -> Void) -> NotificationToken {
        realmManager.observeRuins(block)
    }
    
    public func observeBlocks(_ block: @escaping (RealmCollectionChange<Results<BlockObject>>) -> Void) -> NotificationToken {
        realmManager.observeBlocks(block)
    }
}
