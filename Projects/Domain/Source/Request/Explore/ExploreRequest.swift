//
//  ExploreRequest.swift
//  Domain
//
//  Created by 김은찬 on 6/17/25.
//

import Foundation

struct ExploreRequest: RequestProtocol {
    public let minLat: Double
    public let maxLat: Double
    public let minLng: Double
    public let maxLng: Double
    
    public init(minLat: Double, maxLat: Double, minLng: Double, maxLng: Double) {
        self.minLat = minLat
        self.maxLat = maxLat
        self.minLng = minLng
        self.maxLng = maxLng
    }
}
