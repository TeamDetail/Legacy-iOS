//
//  CreateBlockRequest.swift
//  Domain
//
//  Created by 김은찬 on 7/10/25.
//

import Foundation

public struct CreateBlockRequest: RequestProtocol {
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
