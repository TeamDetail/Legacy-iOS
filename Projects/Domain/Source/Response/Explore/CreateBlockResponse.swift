//
//  CreateBlockResponse.swift
//  Domain
//
//  Created by 김은찬 on 7/10/25.
//

import Foundation

public struct CreateBlockResponse: ResponseProtocol {
    public let blockId: Int
    public let blockType: BlockType
    public let latitude: Double
    public let longitude: Double
    
    public init(
        blockId: Int,
        blockType: BlockType,
        latitude: Double,
        longitude: Double
    ) {
        self.blockId = blockId
        self.blockType = blockType
        self.latitude = latitude
        self.longitude = longitude
    }
}
