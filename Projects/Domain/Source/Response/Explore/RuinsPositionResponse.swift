//
//  RuinsPositionResponse.swift
//  Domain
//
//  Created by 김은찬 on 6/19/25.
//

import Foundation

public struct RuinsPositionResponse: Decodable {
    public let ruinsId: Int
    public let latitude: Double
    public let longitude: Double
    
    public init(ruinsId: Int, latitude: Double, longitude: Double) {
        self.ruinsId = ruinsId
        self.latitude = latitude
        self.longitude = longitude
    }
}
