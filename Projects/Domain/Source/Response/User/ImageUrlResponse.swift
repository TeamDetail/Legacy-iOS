//
//  ImageUrlResponse.swift
//  Domain
//
//  Created by 김은찬 on 9/25/25.
//

import Foundation

public struct ImageUrlResponse: ResponseProtocol {
    public let uploadUrl: String
    public let imageUrl: String
    
    public init(uploadUrl: String, imageUrl: String) {
        self.uploadUrl = uploadUrl
        self.imageUrl = imageUrl
    }
}
