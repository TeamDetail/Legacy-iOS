//
//  AlarmRequest.swift
//  Domain
//
//  Created by 김은찬 on 9/10/25.
//

import Foundation

public struct AlarmRequest: RequestProtocol {
    public let lat: Double
    public let lng: Double
    public let title: String
    public let targetToken: String
    
    public init(lat: Double, lng: Double, title: String, targetToken: String) {
        self.lat = lat
        self.lng = lng
        self.title = title
        self.targetToken = targetToken
    }
}
