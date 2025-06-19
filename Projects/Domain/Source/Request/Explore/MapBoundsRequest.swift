//
//  MapBounds.swift
//  Domain
//
//  Created by 김은찬 on 6/19/25.
//

import Foundation

public struct MapBoundsRequest: RequestProtocol {
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
