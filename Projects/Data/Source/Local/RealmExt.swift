//
//  RealmExt.swift
//  Data
//
//  Created by 김은찬 on 7/29/25.
//

import Domain

extension RuinsObject {
    convenience init(value response: RuinsPositionResponse) {
        self.init()
        self.ruinsId = response.ruinsId
        self.latitude = response.latitude
        self.longitude = response.longitude
    }
}

extension BlockObject {
    convenience init(value response: CreateBlockResponse) {
        self.init()
        self.blockId = response.blockId
        self.blockType = response.blockType.rawValue
        self.latitude = response.latitude
        self.longitude = response.longitude
    }
}

extension RuinsPositionResponse {
    init(realmObject object: RuinsObject) {
        self.init(
            ruinsId: object.ruinsId,
            latitude: object.latitude,
            longitude: object.longitude
        )
    }
}

extension CreateBlockResponse {
    init(realmObject object: BlockObject) {
        let blockTypeEnum: BlockType = BlockType(rawValue: object.blockType)!
        self.init(
            blockId: object.blockId,
            blockType: blockTypeEnum,
            latitude: object.latitude,
            longitude: object.longitude
        )
    }
}
