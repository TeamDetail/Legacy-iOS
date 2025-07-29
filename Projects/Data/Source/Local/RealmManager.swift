//
//  RealmManager.swift
//  Data
//
//  Created by 김은찬 on 7/29/25.
//

import RealmSwift

public final class RealmManager {
    public static let shared = RealmManager()
    
    private let realm: Realm
    
    private init() {
        realm = try! Realm()
    }
    
    // MARK: - Ruins 저장
    public func saveRuins(_ ruins: [RuinsObject]) {
        try! realm.write {
            realm.add(ruins, update: .modified)
        }
    }
    
    // MARK: - Ruins 조회
    public func fetchRuins() -> Results<RuinsObject> {
        return realm.objects(RuinsObject.self)
    }
    
    // MARK: - Blocks 저장
    public func saveBlocks(_ blocks: [BlockObject]) {
        try! realm.write {
            realm.add(blocks, update: .modified)
        }
    }
    
    // MARK: - Blocks 조회
    public func fetchBlocks() -> Results<BlockObject> {
        return realm.objects(BlockObject.self)
    }
    
    // MARK: - 변경 감지
    public func observeRuins(_ block: @escaping (RealmCollectionChange<Results<RuinsObject>>) -> Void) -> NotificationToken {
        return fetchRuins().observe(block)
    }
    
    public func observeBlocks(_ block: @escaping (RealmCollectionChange<Results<BlockObject>>) -> Void) -> NotificationToken {
        return fetchBlocks().observe(block)
    }
}
