//
//  BlockRealm.swift
//  Data
//
//  Created by 김은찬 on 7/29/25.
//

import RealmSwift
import Domain

public class RuinsObject: Object {
    @Persisted(primaryKey: true) public var ruinsId: Int
    @Persisted public var latitude: Double
    @Persisted public var longitude: Double
    public override init() { super.init() }
}

public class BlockObject: Object {
    @Persisted(primaryKey: true) public var blockId: Int
    @Persisted public var blockType: String
    @Persisted public var latitude: Double
    @Persisted public var longitude: Double
    public override init() { super.init() }
}
