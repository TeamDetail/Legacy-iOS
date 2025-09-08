//
//  CommentRequest.swift
//  Domain
//
//  Created by 김은찬 on 9/7/25.
//

import Foundation

public struct CommentRequest: RequestProtocol {
    public let ruinsId: Int
    public let rating: Double
    public let comment: String
    
    public init(ruinsId: Int, rating: Double, comment: String) {
        self.ruinsId = ruinsId
        self.rating = rating
        self.comment = comment
    }
}
